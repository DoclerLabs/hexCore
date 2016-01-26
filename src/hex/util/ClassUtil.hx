package hex.util;

import hex.error.IllegalArgumentException;
import hex.log.Stringifier;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class ClassUtil
{
    function new()
    {
        throw new PrivateConstructorException( "'" + Stringifier.stringify( this ) + "' class can't be instantiated." );
    }

    static public function getInheritanceChain( clazz : Class<Dynamic> ) : Array<Class<Dynamic>>
    {
        var inherintanceChain = [ clazz ];
        while ( ( clazz = Type.getSuperClass( clazz ) ) != null )
        {
            inherintanceChain.push( clazz );
        }
        return inherintanceChain;
    }
	
	static public function classExtendsOrImplements( classOrClassName : Dynamic, superClass : Class<Dynamic> ) : Bool
	{
		var actualClass : Class<Dynamic> = null;
		
		if ( Std.is( classOrClassName, Class ) )
		{
			actualClass = cast( classOrClassName, Class<Dynamic> );
		}
		else if ( Std.is( classOrClassName, String ) )
		{
			try
			{
				actualClass = Type.resolveClass( cast( classOrClassName, String ) );
			}
			catch ( e : Dynamic )
			{
				throw "The class name " + classOrClassName + " is not valid because of " + e + "\n" + e.getStackTrace();
			}
		}
		
		if ( actualClass == null )
		{
			throw new IllegalArgumentException( "The parameter classOrClassName must be a Class or fully qualified class name." );
		}
		
		var classInstance = Type.createEmptyInstance( actualClass );
		return Std.is( classInstance, superClass );
	}
}
