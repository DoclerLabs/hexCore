package hex.util;

import haxe.ds.StringMap;
import haxe.macro.Context;
import haxe.macro.Expr;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class ArrayUtil
{
	/** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }
	
	public static function indexOf<T>( a : Array<T>, element : T ) : Int
	{
		#if !neko
			return a.indexOf( element );
		#else
		if ( Reflect.isFunction( element ) )
		{
			var length = a.length;
			for ( i in 0...length )
			{
				var el = a[ i ];
				if ( Reflect.compareMethods( el, element ) )
				{
					return i;
				}
			}
				
			return -1;
		}
		else
		{
			return a.indexOf( element );
		}
		#end
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
		return ArrayUtil._getLeftNames( e )[ 0 ];
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
	
	macro public static function count<T>( a : ExprOf<Array<T>>, f : ExprOf<Bool> ) : ExprOf<Int>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
		var locals 		= ArrayUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var count 		= locals.pop();

		return macro
		{
			var $count = 0;
			for( $i{leftName} in $a )
			{
				if( $fExp ) $i{count} += 1;
			}
			$i{count};
		}
	}
	
	macro public static function find<T>( a : ExprOf<Array<T>>, f : ExprOf<Bool> ) : ExprOf<T>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
		var locals 		= ArrayUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var result 		= locals.pop();

		return macro
		{
			var $result = null;
			for( $i{leftName} in $a )
			{
				if( $fExp ) 
				{
					$i {result} = $i {leftName};
					break;
				}
			}
			$i{result};
		}
	}
	
	macro public static function forEach<T, F>( a : ExprOf<Array<T>>, f ) : ExprOf<Void>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
		
		var locals 		= ArrayUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var fName 		= locals.pop();

		return macro
		{
			for( $i{leftName} in $a )
			{
				$fExp;
			}
		}
	}
	
	macro public static function forEachCall<T, F>( a : ExprOf<Array<T>>, f ) : ExprOf<Void>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;

		return macro
		{
			for( $i{leftName} in $a )
			{
				$fExp( $i{leftName} );
			}
		}
	}
	
	macro public static function findIndex<T>( a : ExprOf<Array<T>>, f : ExprOf<Bool> ) : ExprOf<Int>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
		var locals 		= ArrayUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var index 		= locals.pop();

		return macro
		{
			var $index 	= 0;
			for( $i{leftName} in $a )
			{
				$i { index } += 1;
				if( $fExp ) 
				{
					$i {index};
					break;
				}
			}
			-1;
		}
	}
	
	macro public static function filters<T>( a : ExprOf<Array<T>>, f : ExprOf<Bool> ) : ExprOf<Array<T>>
	{
		var ad 			= ArrayUtil.arrowDecompose( f );
		var leftName 	= ArrayUtil._getLeftName( ad.left );
		var fExp 		= ad.right;
		var locals 		= ArrayUtil._getUniqueLocalVarNames( 1, Context.getLocalTVars() );
		var result 		= locals.pop();

		return macro
		{
			var $result = [];
			for ( $i{leftName} in $a )
			{
				if ( $fExp ) 
				{
					$i{result}.push( $i {leftName} );
				}
			}
			$i{result};
		}
	}
}