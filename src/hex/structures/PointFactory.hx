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
	
	inline static public function build( x : Int = 0, y : Int = 0 ) : Point
	{
		return new Point( x, y );
	}
}