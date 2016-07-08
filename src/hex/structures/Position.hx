package hex.structures;

/**
 * ...
 * @author Francis Bourre
 */
abstract Position( IPoint )
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
	
	public inline function new( x : Float, y : Float ) 
	{
		this = { x: x, y: y };
	}
	
	@:from public static inline function fromIPoint( p : IPoint ) : Position 
	{
		return cast p;
	}
	
	@:from public static inline function fromISize( s : ISize ) : Position 
	{
		return new Position( s.width, s.height );
	}
	
	@:to public inline function toSize() : Size
	{
		return new Size( this.x, this.y );
	}
	
	@:to public inline function toArray() : Array<Float>
	{
		return [ this.x, this.y ];
	}
	
	@:op( A + B ) public static inline function plus( p1 : Position, p2 : Position ) : Position
	{
		return { x: p1.x + p2.x, y: p1.y + p2.y };
	}
	
	@:op( A += B ) public static inline function plusEquals( p1 : Position, p2 : Position ) : Void
	{
		p1.x += p2.x;
		p1.y += p2.y;
	}
	
	@:op( A - B ) public static inline function minus( p1 : Position, p2 : Position ) : Position
	{
		return { x: p1.x - p2.x, y: p1.y - p2.y };
	}
	
	@:op( A -= B ) public static inline function minusEquals( p1 : Position, p2 : Position ) : Void
	{
		p1.x -= p2.x;
		p1.y -= p2.y;
	}
	
	@:op( A * B ) public static inline function multiply( p1 : Position, p2 : Position ) : Position
	{
		return { x: p1.x * p2.x, y: p1.y * p2.y };
	}
	
	@:op( A *= B ) public static inline function multiplyEquals( p1 : Position, p2 : Position ) : Void
	{
		p1.x *= p2.x;
		p1.y *= p2.y;
	}
	
	@:op( A / B ) public static inline function divide( p1 : Position, p2 : Position ) : Position
	{
		return { x: p1.x / p2.x, y: p1.y / p2.y };
	}
	
	@:op( A /= B ) public static inline function divideEquals( p1 : Position, p2 : Position ) : Void
	{
		p1.x /= p2.x;
		p1.y /= p2.y;
	}
	
	@:op( A == B ) public static inline function equals( p1 : Position, p2 : Position ) : Bool
	{
		return ( p1.x == p2.x ) &&  ( p1.y == p2.y );
	}
	
	@:op( A != B ) public static inline function unequals( p1 : Position, p2 : Position ) : Bool
	{
		return ( p1.x != p2.x ) ||  ( p1.y != p2.y );
	}
	
	@:op( A = B ) public static inline function assigns( p1 : Position, p2 : Position ) : Void
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