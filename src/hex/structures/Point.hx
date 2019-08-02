package hex.structures;

/**
 * ...
 * @author Francis Bourre
 */
abstract Point( IPoint ) to IPoint from IPoint
{
	public var x( get, set ) : Int;
    public var y( get, set ) : Int;
	
    inline public function get_x() : Int
	{
		return this.x;
	}
	
    inline public function set_x( v : Int ) : Int
	{
		return this.x = v;
	}
	
    inline public function get_y() : Int
	{
		return this.y;
	}
	
    inline public function set_y( v : Int ) : Int
	{
		return this.y = v;
	}
	
	public inline function new( x : Int = 0, y : Int = 0 ) 
	{
		this = { x: x, y: y };
	}
	
	@:from public static inline function fromIPoint( p : IPoint ) : Point 
	{
		return cast p;
	}
	
	@:from public static inline function fromISize( s : ISize ) : Point 
	{
		return new Point( Std.int( s.width ), Std.int( s.height ) );
	}
	
	@:to public inline function toSize() : Size
	{
		return new Size( this.x, this.y );
	}
	
	@:to public inline function toArray() : Array<Int>
	{
		return [ this.x, this.y ];
	}
	
	@:op( A + B ) public static inline function plus( p1 : Point, p2 : Point ) : Point
	{
		return { x: p1.x + p2.x, y: p1.y + p2.y };
	}
	
	@:op( A += B ) public static inline function plusEquals( p1 : Point, p2 : Point ) : Void
	{
		p1.x += p2.x;
		p1.y += p2.y;
	}
	
	@:op( A - B ) public static inline function minus( p1 : Point, p2 : Point ) : Point
	{
		return { x: p1.x - p2.x, y: p1.y - p2.y };
	}
	
	@:op( A -= B ) public static inline function minusEquals( p1 : Point, p2 : Point ) : Void
	{
		p1.x -= p2.x;
		p1.y -= p2.y;
	}
	
	@:op( A * B ) public static inline function multiply( p1 : Point, p2 : Point ) : Point
	{
		return { x: p1.x * p2.x, y: p1.y * p2.y };
	}
	
	@:op( A *= B ) public static inline function multiplyEquals( p1 : Point, p2 : Point ) : Void
	{
		p1.x *= p2.x;
		p1.y *= p2.y;
	}
	
	@:op( A / B ) public static inline function divide( p1 : Point, p2 : Point ) : Point
	{
		return { x: Std.int( p1.x / p2.x ), y: Std.int( p1.y / p2.y ) };
	}
	
	@:op( A /= B ) public static inline function divideEquals( p1 : Point, p2 : Point ) : Void
	{
		p1.x = Std.int( p1.x / p2.x );
		p1.y = Std.int( p1.y / p2.y );
	}
	
	@:op( A == B ) public static inline function equals( p1 : Point, p2 : Point ) : Bool
	{
		return ( p1.x == p2.x ) &&  ( p1.y == p2.y );
	}
	
	@:op( A != B ) public static inline function unequals( p1 : Point, p2 : Point ) : Bool
	{
		return ( p1.x != p2.x ) ||  ( p1.y != p2.y );
	}	
}

private typedef IPoint =
{
	x : Int,
	y : Int
}

private typedef ISize =
{
	width : Float,
	height : Float
}