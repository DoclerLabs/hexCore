package hex.util;

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
        throw new PrivateConstructorException( "This class can't be instantiated." );
    }
	
	public static function findIndex<T>( a : Array<T>, f : T -> Bool ) : Int 
	{
		for ( i in 0...a.length ) if ( f( a[ i ] ) ) return i;
		return -1;
	}
	
	public static function findElement<T>( a : Array<T>, f : T -> Bool ) : T
	{
		for ( i in 0...a.length )
		{
			var e = a[ i ];
			if ( f( e ) ) return e;
		}
		return null;
	}
	
	public static function doWhen<T>( a : Array<T>, f : T -> Bool, ff : T -> Int -> Void ) : Void
	{
		var i = a.length;
		while ( i-- > 0 )
		{
			var e = a[ i ];
			if ( f( e ) ) ff ( e, i );
		}
	}
	
	public static function doOnFirstWhen<T>( a : Array<T>, f : T -> Bool, ff : T -> Int -> Void ) : Void
	{
		for ( i in 0...a.length )
		{
			var e = a[ i ];
			if ( f( e ) ) 
			{
				ff ( e, i );
				break;
			}
		}
	}
	
	public static function doOnAll<T>( a : Array<T>, f : T -> Int -> Void ) : Void
	{
		var i = a.length;
		while ( i-- > 0 )
		{
			var e = a[ i ];
			f ( e, i );
		}
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
	
	static function leftName( e : Expr )
	{
		return leftNames( e )[ 0 ];
	}
	
	static function leftNames( L : Expr, min : Int = 1 )
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
	
	macro public static function count<T>( a : ExprOf<Array<T>>, f : ExprOf<Bool> ) : Expr
	{
		var ad 		= arrowDecompose( f );
		var lName 	= leftName( ad.left );
		var rVal 	= ad.right;

		return macro
		{
			var c = 0;
			for ( $i{lName} in $a )
			{
				if ($rVal) c += 1;
			}
			c;
		}
	}
}