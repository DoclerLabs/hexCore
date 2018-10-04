package hex.util;

#if macro
using tink.MacroApi;

/**
 * ...
 * @author Francis Bourre
 */
class TinkHelper 
{
	function new() {}
	
	static public function fcqn( ct : haxe.macro.Expr.ComplexType ) : String
	{
		var s = ct.toType().sure().toComplex().toString();
		return s.split( 'StdTypes.' ).join( '' ).split(' ').join('').split('()').join('Void');
	}
}
#end
