package hex.structures;

/**
 * ...
 * @author duke
 */
class Size
{
	public var width : Float;
	public var height : Float;

	public function new( width : Float = 0, height : Float = 0 )
	{
		this.width = width;
		this.height = height;
	}

	public function equals( size : Size ) : Bool
	{
		return ( this.width == size.width && this.height == size.height );
	}

	public function setSize( size : Size ) : Void
	{
		if ( size != null )
		{
			this.width = size.width;
			this.height = size.height;
		}
	}

	public function setSizeWH( width : Float, height : Float ) : Void
	{
		if ( !Math.isNaN( width ) ) 
		{
			this.width = width;
		}
		
		if ( !Math.isNaN( height ) ) 
		{
			this.height = height;
		}
	}

	public function clone() : Size
	{
		return new Size( this.width, this.height );
	}

	public function scale( factor : Float ) : Size
	{
		if ( !Math.isNaN( factor ) )
		{
			return new Size( this.width * factor, this.height * factor );
		}
		else 
		{
			return this.clone();
		}
	}

	public function substract( size : Size ) : Size
	{
		if ( size != null )
		{
			return new Size( this.width - size.width, this.height - size.height );
		}
		else 
		{
			return this.clone();
		}
	}

	public function add( size : Size ) : Size
	{
		if( size != null )
		{
			return new Size( this.width + size.width, this.height + size.height );
		}
		else 
		{
			return this.clone();
		}
	}

	public function toPoint() : Point
	{
		return new Point( Std.int( this.width ), Std.int( this.height ) );
	}
}