package hex.util;

using hex.error.Error;

/**
 * ...
 * @author Francis Bourre
 */
class ArrayUtil
{
	/** @private */ function new() throw new PrivateConstructorException();
	
	public static function indexOf<T>( a : Array<T>, element : T ) : Int
	{
		#if (!neko && !php)
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
}