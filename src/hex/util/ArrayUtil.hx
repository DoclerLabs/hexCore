package hex.util;

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
	public static function countWhen<T>( a : Array<T>, f : T -> Bool ) : Int
	{
		var c = 0;
		for ( e in a ) if ( f( e ) ) c++;
		return c;
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
}