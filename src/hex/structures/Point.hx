package hex.structures; 

/**
 * ...
 * @author duke
 */
class Point
{
	public var x : Float;
	public var y : Float;

	public function new( x : Float = 0, y : Float = 0 ) 
	{
		this.x = x;
		this.y = y;
	}

	public function equals( point : Point ) : Bool
	{
		return ( this.x == point.x && this.y == point.y );
	}
}