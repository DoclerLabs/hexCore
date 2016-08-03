package hex.util;

import hex.error.IllegalArgumentException;
import hex.error.PrivateConstructorException;
import hex.log.Stringifier;

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
	
	static public function getInheritanceChainFrom( instance : Dynamic ) : Array<Class<Dynamic>>
	{
		var type : Class<Dynamic> = Type.getClass( instance );
		return type != null ? ClassUtil.getInheritanceChain( type ) : [];
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
	
	static public function getStaticVariableReference( qualifiedClassName : String ) : Dynamic
	{
		var a : Array<String> = qualifiedClassName.split( "." );
		var type : String = a[ a.length - 1 ];
		a.splice( a.length - 1, 1 );
		var classReference : Class<Dynamic>  = ClassUtil.getClassReference( a.join( "." ) );
		var staticRef : Dynamic = Reflect.field( classReference, type );
		
		if ( staticRef == null )
		{
			throw new IllegalArgumentException( "ClassUtil.getStaticReference fails with '" + qualifiedClassName + "'" );
		}
		
		return staticRef;
	}
	
	static public function getClassNameFromFullyQualifiedName( qualifiedClassName : String ) : String
	{
		var a : Array<String> = qualifiedClassName.split( "." );
		return  a[ a.length - 1 ];
	}
	
	static public function getClassNameFromStaticReference( qualifiedClassName : String ) : String
	{
		var a : Array<String> = qualifiedClassName.split( "." );
		var type : String = a[ a.length - 1 ];
		a.splice( a.length - 1, 1 );
		return  a.join( "." );
	}
	
	static public function getStaticVariableNameFromStaticReference( qualifiedClassName : String ) : String
	{
		var a : Array<String> = qualifiedClassName.split( "." );
		return a[ a.length - 1 ];
	}
	
	static public function getClassReference( qualifiedClassName : String ) : Class<Dynamic>
	{
		var classReference : Class<Dynamic> = Type.resolveClass( qualifiedClassName );
		
		if ( classReference == null )
		{
			throw new IllegalArgumentException( "ClassUtil.getClassReference fails with class named '" + qualifiedClassName + "'" );
		}
		
		return classReference;
	}
	
	static public function getClassName<T>( target : T ) : String
	{
		var type = Type.getClassName( Type.getClass( target ) );
		return type != null ? type : "Dynamic";
	}
}
