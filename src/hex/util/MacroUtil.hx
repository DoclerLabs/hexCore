package hex.util;

import haxe.macro.ComplexTypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Expr.TypeParam;
import haxe.macro.Expr.TypePath;
import haxe.macro.ExprTools;
import haxe.macro.Type.ClassType;
import haxe.macro.TypeTools;

/**
 * ...
 * @author Francis Bourre
 */
class MacroUtil
{
	/** @private */ function new() throw new hex.error.PrivateConstructorException();

	macro public static function classImplementsInterface( classRef : haxe.macro.Expr.ExprOf<String>, interfaceRef : haxe.macro.Expr.ExprOf<String> ) : Expr
	{
		var classType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( classRef ) );
		var interfaceType = MacroUtil.getClassType( haxe.macro.ExprTools.toString( interfaceRef ) );

		var b = MacroUtil.implementsInterface( classType, interfaceType );
		return macro { $v{ b } };
	}

	macro public static function classIsSubClassOf( classRef : haxe.macro.Expr.ExprOf<String>, subClassRef : haxe.macro.Expr.ExprOf<String> ) : Expr
	{
		var classType 		= MacroUtil.getClassType( haxe.macro.ExprTools.toString( classRef ) );
		var subClassType 	= MacroUtil.getClassType( haxe.macro.ExprTools.toString( subClassRef ) );
		return macro { $v{ MacroUtil.isSubClassOf( classType, subClassType ) } };
	}
	
	#if macro
	static public function flatToExpr( a : Array<Expr>, to : Expr )
	{
		a = a.copy();
		a.unshift( to );
		return macro $b{a};
	}
	
	static public function append( eThis, eTo ) : Expr
	{
		return switch( eTo.expr )
		{
			case EBlock( exprs ): { expr: EBlock( exprs.concat( [ eThis ] ) ), pos: eThis.pos };
			case _: { expr: EBlock( [ eTo, eThis ] ), pos: eThis.pos };
		}
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

	static public function getTypePath( className : String, ?params : Array<TypeParam>, position : Position = null ) : TypePath
	{
		if ( position != null )
		{
			try
			{
				Context.getType( className );
			}
			catch( e : Dynamic )
			{
				Context.error( "Fails to retrieve TypePath for class named '" + className + "'\nError caught: " + e, position );
			}
		}
		else
		{
			Context.getType( className );
		}
		
		var pack = className.split( "." );
		var className = pack[ pack.length -1 ];
		pack.splice( pack.length - 1, 1 );
		
		return { pack: pack, name: className, params:params };
	}
	
	static public function getStaticVariable( staticReference : String, position : Position = null ) : Expr
	{
		var className 		= ClassUtil.getClassNameFromStaticReference( staticReference );
		var staticVarName 	= ClassUtil.getStaticVariableNameFromStaticReference( staticReference );
		var tp 				= MacroUtil.getPack( className );

		if ( position != null )
		{
			return macro @:pos( position) { $p { tp } .$staticVarName; };
		}
		else
		{
			return macro { $p { tp } .$staticVarName; };
		}
	}
	
	static public function getClassType( qualifiedClassName : String, position : Position = null ) : ClassType
	{
		var type = null;
		
		try
		{
			type = Context.getType( qualifiedClassName );
		}
		catch( e : Dynamic )
		{
			Context.error( "Fails to retrieve ClassType for class named '" + qualifiedClassName + "'\nError caught: " + e, position == null ? Context.currentPos() : position );
		}
		
		switch type 
		{
			case TInst( t, _ ):
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
	
	static public function getPack( className : String, position : Position = null ) : Array<String>
	{
		try
		{
			Context.getType( className );
		}
		catch ( e : Dynamic )
		{
			Context.error( "Fails to retrieve pack for class named '" + className + "'\nError caught: " + e, position == null ? Context.currentPos() : position );
		}
		
		return className.split( "." );
	}
	
	static public function getClassFullQualifiedName( p : TypePath ) : String
	{
		var t : haxe.macro.Type = Context.getType( p.pack.concat( [ p.name ] ).join( '.' ) );
		switch ( t )
		{
			case TInst( t, p ):
				var ct = t.get();
				return ct.pack.concat( [ ct.name ] ).join( '.' );
				
			case TAbstract( t, params ):
				return t.toString();
				
			case TDynamic( t ):
				return "Dynamic";
				
			case _: return null;
		}
	}
	
	//TODO implements all cases
	static public function getFQCNFromComplexType( ct : ComplexType ) : String
	{
		switch( ct )
		{
			case TPath( p ):
				var t = ComplexTypeTools.toType( ct );
				var type = TypeTools.toString( t ).split(' ').join( '' );
				switch ( t )
				{
					case TType( _.get().module => module, _ ): 
						if ( type.split('<')[0] != module ) type = module + '.' + type.split('.').pop();
					default: 
				}
				return type;
				
			case TFunction( args, ret ):
				var s = '';
				for ( arg in args ) s += MacroUtil.getFQCNFromComplexType( arg ) + '->';
				s += MacroUtil.getFQCNFromComplexType( ret );
				return s;
	
			case _:
				return 'Dynamic';
		}
	}
	
	static public inline function getFQCNFromExpression( e : Expr ) : String
		return MacroUtil.getFQCNFromComplexType( TypeTools.toComplexType( Context.typeof( e ) ) );
	
	static public inline function instantiate( t : TypePath, ?args ) : ExprDef
		return ENew( t, args == null ? [] : args );
	
	static public inline function assertTypeMatching( typeName1 : String, typeName2 : String, ?pos : Position ) : Void
	{
		var varType1 = MacroUtil.getComplexTypeFromString( typeName1 );
		var varType2 = MacroUtil.getComplexTypeFromString( typeName2 );
		
		Context.typeof( 
			macro @:pos( pos != null? pos: Context.currentPos() ) 
				{ var o2 : $varType2 = null; var o1 : $varType1 = o2; } );
	}
	
	static public inline function assertValueMatching( typeName : String, value : Expr, ?pos : Position ) : Void
	{
		//check type matching
		var varType = MacroUtil.getComplexTypeFromString( typeName );
		Context.typeof( macro @:pos( pos != null? pos: Context.currentPos() ) { var v : $varType = $value; } );
	}
	
	static public inline function getComplexTypeFromString( typeName : String ) : Null<ComplexType>
		return TypeTools.toComplexType( 
						Context.typeof( 
							Context.parseInlineString( '( null : ${typeName})', Context.currentPos() ) ) );
	#end
}
