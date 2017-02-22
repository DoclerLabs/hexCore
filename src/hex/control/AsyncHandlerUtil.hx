package hex.control;

import haxe.ds.StringMap;
import haxe.macro.Context;
import haxe.macro.Expr;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncHandlerUtil
{
	/** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }
	
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
		return AsyncHandlerUtil._getLeftNames( e )[ 0 ];
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
	
	macro public static function on<T>( h : ExprOf<ICompletable<T>>, f : Expr ) : ExprOf<ICompletable<T>>
	{
		var ad 			= AsyncHandlerUtil.arrowDecompose( f );
		var leftName 	= AsyncHandlerUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
	
		var locals 		= AsyncHandlerUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var fName 		= locals.pop();
	
		var mm = macro { function $fName( $leftName ) { return $fExp; } };
		return macro
		{
			$h.onComplete( $mm );
		}
	}
	
	macro public static function triggers<T>( h : ExprOf<ICompletable<T>>, newHandler : ExprOf<ICompletable<T>> ) : ExprOf<ICompletable<T>>
	{
		var arg = AsyncHandlerUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() ).pop();
		
		return macro
		{
			var $arg = ( $newHandler );
			$h.onComplete( $i{arg}.complete );
			$i{arg};
		}
	}
}