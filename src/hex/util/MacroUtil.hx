package hex.util;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.TypeParam;
import haxe.macro.Expr.TypePath;
import haxe.macro.Type.ClassType;

/**
 * ...
 * @author Francis Bourre
 */
class MacroUtil
{
	function new() 
	{
		
	}
	
	#if macro
	static public function getTypePath( className : String, ?params:Array<TypeParam> ) : TypePath
	{
		Context.getType( className );
		var pack = className.split( "." );
		var className = pack[ pack.length -1 ];
		pack.splice( pack.length - 1, 1 );
		
		
		return { pack: pack, name: className, params:params };
	}
	
	static public function getStaticVariable( staticReference : String ) : Expr
	{
		var className = ClassUtil.getClassNameFromStaticReference( staticReference );
		var staticVarName = ClassUtil.getStaticVariableNameFromStaticReference( staticReference );
		var tp = MacroUtil.getPack( className );
		return macro { $p { tp }.$staticVarName; };
	}
	
	static public function getClassType( qualifiedClassName : String ) : ClassType
	{
		var type = Context.getType( qualifiedClassName );
		
		switch type 
		{
			case TInst(t, _):
				var classType = t.get();
				return classType;
			default:
				return null;
		}
	}
		
	public static function isSubClassOf( subClass : ClassType, baseClass : ClassType ) : Bool 
	{
		var cls = subClass;
		while ( cls.superClass != null )
		{
			cls = cls.superClass.t.get();
			if ( isSameClass( baseClass, cls ) ) 
			{ 
				return true; 
			}
		}
		
		return false;
	}
	
	public static function implementsInterface( cls : ClassType, interfaceToMatch : ClassType ) : Bool 
	{
		while ( cls != null ) 
		{
			for ( i in cls.interfaces ) 
			{
				//check super interfaces
				for ( ie in i.t.get().interfaces )
				{
					if ( isSameClass( ie.t.get(), interfaceToMatch ) )
					{
						return true;
					}
				}

				if ( isSameClass( i.t.get(), interfaceToMatch ) ) 
				{
					return true;
				}
			}
			
			if ( cls.superClass != null ) 
			{
				cls = cls.superClass.t.get();
			}
			else 
			{
				cls = null;
			}
		}
		
		return false;
	}

	static public function isSameClass( a : ClassType, b : ClassType ) : Bool 
	{
		return ( a.pack.join( "." ) == b.pack.join( "." ) && a.name == b.name );
	}
	
	static public function getPack( className : String ) : Array<String>
	{
		Context.getType( className );
		return className.split( "." );
	}
	
	static public function getClassFullQualifiedName( p : TypePath ) : String
	{
		var t : haxe.macro.Type = Context.getType( p.pack.concat( [ p.name ] ).join( '.' ) );
		switch ( t )
		{
			case TInst( t, p ):
				var ct = t.get();
				return ct.pack.concat( [ct.name] ).join( '.' );
			case TAbstract( t, params ):
				return t.toString();
			case TDynamic( t ):
				return "Dynamic";
			default: return null;
		}
	}
	#end
}
