package hex.util;

import haxe.macro.Context;
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
	#end
}