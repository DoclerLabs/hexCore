package hex.structures;

/**
 * ...
 * @author Francis Bourre
 */
abstract PointF( IPoint )
{
	public var x( get, set ) : Float;
    public var y( get, set ) : Float;
	
    inline public function get_x() : Float
	{
		return this.x;
	}
	
    inline public function set_x( v : Float ) : Float
	{
		return this.x = v;
	}
	
    inline public function get_y() : Float
	{
		return this.y;
	}
	
    inline public function set_y( v : Float ) : Float
	{
		return this.y = v;
	}
	
	public inline function new( x : Float = 0.0, y : Float = 0.0 ) 
	{
		this = { x: x, y: y };
	}
	
	@:from public static inline function fromIPoint( p : IPoint ) : PointF 
	{
		return cast p;
	}
	
	@:from public static inline function fromISize( s : ISize ) : PointF 
	{
		return new PointF( s.width, s.height );
	}
	
	@:to public inline function toSize() : Size
	{
		return new Size( this.x, this.y );
	}
	
	@:to public inline function toArray() : Array<Float>
	{
		return [ this.x, this.y ];
	}
	
	@:op( A + B ) public static inline function plus( p1 : PointF, p2 : PointF ) : PointF
	{
		return { x: p1.x + p2.x, y: p1.y + p2.y };
	}
	
	@:op( A += B ) public static inline function plusEquals( p1 : PointF, p2 : PointF ) : Void
	{
		p1.x += p2.x;
		p1.y += p2.y;
	}
	
	@:op( A - B ) public static inline function minus( p1 : PointF, p2 : PointF ) : PointF
	{
		return { x: p1.x - p2.x, y: p1.y - p2.y };
	}
	
	@:op( A -= B ) public static inline function minusEquals( p1 : PointF, p2 : PointF ) : Void
	{
		p1.x -= p2.x;
		p1.y -= p2.y;
	}
	
	@:op( A * B ) public static inline function multiply( p1 : PointF, p2 : PointF ) : PointF
	{
		return { x: p1.x * p2.x, y: p1.y * p2.y };
	}
	
	@:op( A *= B ) public static inline function multiplyEquals( p1 : PointF, p2 : PointF ) : Void
	{
		p1.x *= p2.x;
		p1.y *= p2.y;
	}
	
	@:op( A / B ) public static inline function divide( p1 : PointF, p2 : PointF ) : PointF
	{
		return { x: p1.x / p2.x, y: p1.y / p2.y };
	}
	
	@:op( A /= B ) public static inline function divideEquals( p1 : PointF, p2 : PointF ) : Void
	{
		p1.x /= p2.x;
		p1.y /= p2.y;
	}
	
	@:op( A == B ) public static inline function equals( p1 : PointF, p2 : PointF ) : Bool
	{
		return ( p1.x == p2.x ) &&  ( p1.y == p2.y );
	}
	
	@:op( A != B ) public static inline function unequals( p1 : PointF, p2 : PointF ) : Bool
	{
		return ( p1.x != p2.x ) ||  ( p1.y != p2.y );
	}
	
	@:op( A = B ) public static inline function assigns( p1 : PointF, p2 : PointF ) : Void
	{
		p1.x = p2.x;
		p1.y = p2.y;
	}
}

private typedef IPoint =
{
	x : Float,
	y : Float
}

private typedef ISize =
{
	width : Float,
	height : Float
}