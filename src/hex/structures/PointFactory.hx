package hex.structures;

/**
 * ...
 * @author Francis Bourre
 */
class PointFactory
{
	function new() 
	{
		
	}
	
	static public function build( x : Int, y : Int ) : { x : Int, y : Int }
	{
		return { x: x, y: y };
	}
}