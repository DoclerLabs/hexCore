package hex.control.async;

import haxe.ds.StringMap;
import haxe.macro.Context;
import haxe.macro.Expr;
import hex.error.Exception;
import hex.error.IllegalStateException;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncCallback<ResultType> implements IAsyncCallback<ResultType>
{
	static var _map 		: Map<AsyncCallback<Dynamic>, Bool> = new Map();
	
	var _completeResponder 	: Array<Callback<ResultType>>;
	var _failResponder 		: Array<Exception->Void>;
	var _cancelResponder 	: Array<Void->Void>;
	var _result				: AsyncResult<ResultType>;
	
	public function new() 
	{
		this._completeResponder 	= [];
		this._failResponder 		= [];
		this._cancelResponder 		= [];
		this._result				= Result.WAITING;
		
		AsyncCallback._map.set( this, true );
	}

	public static function get<ResultType>( callback : Callback<Handler<ResultType>> ) : AsyncCallback<ResultType>
	{
		var acb = new AsyncCallback();
		callback.invoke( acb._complete );
		return acb;
	}
	
	macro public function whenComplete<ResultType>( ethis : Expr, clazz : Expr ) : ExprOf<AsyncCallback<ResultType>>
	{
		return AsyncCallbackUtil.whenComplete( ethis, clazz );
	}
	
	public function onComplete( onComplete : Callback<ResultType> ) : AsyncCallback<ResultType>
	{
		switch( this._result )
		{
			case Result.WAITING:
				this._completeResponder.push( onComplete );
				
			case Result.DONE( result ):
				onComplete.invoke( result );
				
			case _:
		}
		
		return this;
	}
	
	public function onFail( onFail : Exception->Void ) : AsyncCallback<ResultType>
	{
		switch( this._result )
		{
			case Result.WAITING:
				this._failResponder.push( onFail );
				
			case Result.FAILED( error ):
				onFail( error );
				
			case _:
		}
		
		return this;
	}
	
	public function onCancel( onCancel : Void->Void ) : AsyncCallback<ResultType>
	{
		switch( this._result )
		{
			case Result.WAITING:
				this._cancelResponder.push( onCancel );
				
			case Result.CANCELLED:
				onCancel();
				
			case _:
		}
		
		return this;
	}
	
	function _complete( result : AsyncResult<ResultType> ) : Void
	{
		switch( result )
		{	
			case Result.DONE( result ):
				this._doComplete( result );
				
			case Result.FAILED( error ):
				this._doFail( error );
				
			case Result.CANCELLED:
				this._doCancel();
				
			case _:
		}
	}
	
	function _doComplete( result : ResultType ) : Void
	{
		if ( AsyncCallback._map.exists( this ) )
		{
			this._result = result;
			for ( responder in this._completeResponder )
			{
				responder.invoke( result );
			}
			
			this._dispose();
		}
		else
		{
			throw new IllegalStateException( 'AsyncCallback cannot be completed, it is disposed' );
		}
	}
	
	function _doFail( error : Exception ) : Void
	{
		if ( AsyncCallback._map.exists( this ) )
		{
			this._result = error;
			for ( responder in this._failResponder )
			{
				responder( error );
			}
			
			this._dispose();
		}
		else
		{
			throw new IllegalStateException( 'AsyncCallback cannot be failed, it is disposed' );
		}
	}
	
	function _doCancel() : Void
	{
		if ( AsyncCallback._map.exists( this ) )
		{
			this._result = Result.CANCELLED;
			for ( responder in this._cancelResponder )
			{
				responder();
			}
			
			this._dispose();
		}
		else
		{
			throw new IllegalStateException( 'AsyncCallback cannot be cancelled, it is disposed' );
		}
	}
	
	function _dispose() : Void
	{
		AsyncCallback._map.remove( this );
		
		this._completeResponder 	= null;
		this._failResponder 		= null;
		this._cancelResponder 		= null;
	}
}

enum Result<T>
{
	WAITING;
	DONE( result : T );
	FAILED( e : Exception );
	CANCELLED;
}

private class AsyncCallbackUtil 
{
	/** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }
	
	#if macro
	static function arrowDecompose( f: Expr ) : { left: Expr, right: Expr }
	{
		var l: Expr = null;
		var r: Expr = null;
		
		switch( f.expr )
		{
			case EBinop( OpArrow, e1, e2 ):
			{
				l = e1;
				r = e2;
			}
			
			default: r = f;
		}
		
		return { left: l, right: r };
	}
	
	static function _getLeftName( e : Expr )
	{
		return AsyncCallbackUtil._getLeftNames( e )[ 0 ];
	}
	
	static function _getLeftNames( L : Expr, min : Int = 1 )
	{
		var names : Array<String> =
			if ( L != null )
			{
				switch( L.expr )
				{
					case EConst( CIdent( s ) ): [ s ];
					
					case EArrayDecl( els ): 
						els.map( function( e )
							return switch( e.expr )
							{
								case EConst( CIdent( s ) ): s; 
								default: '_';
							});
							
					case _: [];
				}
			}
			else [];
		
		var t = '';
		while ( names.length < min ) names.push( t += '_' );
		return names;
	}
	
	static function _getUniqueLocalVarNames( count, locals ) : Array<String>
	{
		var r = new Array<String>();
		var tmap = new StringMap<Int>();
		
		while ( r.length < count )
		{
			var t = '__tmp_' + Std.random( 0xffffff );
			if ( !locals.exists( t ) && !tmap.exists( t ) )
			{
				r.push( t );
				tmap.set( t, 1 );
			}
		}
		return r;
	}
	
	public static function whenComplete<T>( h : ExprOf<AsyncCallback<T>>, f : Expr ) : ExprOf<AsyncCallback<T>>
	{
		var ad 			= AsyncCallbackUtil.arrowDecompose( f );
		var leftName 	= AsyncCallbackUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
	
		var locals 		= AsyncCallbackUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var fName 		= locals.pop();
	
		var mm = macro { function $fName( $leftName ) { return $fExp; } };
		return macro
		{
			$h.onComplete( $mm );
		}
	}
	#end
}