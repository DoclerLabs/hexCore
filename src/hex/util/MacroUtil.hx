package hex.util;

import haxe.macro.Context;
import haxe.macro.Expr;
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

	macro public static function classImplementsInterface( classRef : haxe.macro.Expr.ExprOf<String>, interfaceRef : haxe.macro.Expr.ExprOf<String> ) : Expr
	{
		var classType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( classRef ) );
		var interfaceType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( interfaceRef ) );

		var b = MacroUtil.implementsInterface( classType, interfaceType );
		return macro { $v{ b } };
	}

	macro public static function classIsSubClassOf( classRef : haxe.macro.Expr.ExprOf<String>, subClassRef : haxe.macro.Expr.ExprOf<String> ) : Expr
	{
		var classType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( classRef ) );
		var subClassType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( subClassRef ) );

		var b = MacroUtil.isSubClassOf( classType, subClassType );
		return macro { $v{ b } };
	}
	
	#if macro
	static public function getStringFromExpr( e : ExprDef ) : String
	{
		switch( e )
		{
			case EConst( CString( s ) ):
				return s;

			default:
				throw "type should be string const";
		}

		return null;
	}

	static public function getClassNameFromExpr( e : Expr ) : String
	{
		var s = haxe.macro.ExprTools.toString( e );

        try
        {
            var t = Context.getType( s );
            switch( t )
            {
                case TInst( t, params ):
                    s = t.toString();

                default:
                    throw "'" + '$s' + "' class is not available";
            }
        }
        catch( e : Dynamic )
        {
            throw "'" + '$s' + "' class is not available";
        }

		return s;
	}

	static public function getTypePath( className : String, ?params:Array<TypeParam> ) : TypePath
	{
		Context.getType( className );
		var pack = className.split( "." );
		var className = pack[ pack.length -1 ];
		pack.splice( pack.length - 1, 1 );
		
		
		return { pack: pack, name: className, params:params };
	}
	
	static public function getStaticVariable( staticReference : String, position : Position = null ) : Expr
	{
		var className = ClassUtil.getClassNameFromStaticReference( staticReference );
		var staticVarName = ClassUtil.getStaticVariableNameFromStaticReference( staticReference );
		var tp = MacroUtil.getPack( className );

		if ( position != null )
		{
			return macro @:pos( position) { $p { tp } .$staticVarName; };
		}
		else
		{
			return macro { $p { tp } .$staticVarName; };
		}
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
