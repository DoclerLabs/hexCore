package hex.util;

import haxe.macro.Context;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.TypeParam;
import haxe.macro.Expr.TypePath;

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
	static public function getTypePath( className : String ) : TypePath
	{
		Context.getType( className );
		var pack = className.split( "." );
		var className = pack[ pack.length -1 ];
		pack.splice( pack.length - 1, 1 );
		
		
		return { pack: pack, name: className };
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