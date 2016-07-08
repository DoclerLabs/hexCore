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
	
	inline static public function build( x : Int, y : Int ) : Point
	{
		return new Point( x, y );
	}
}