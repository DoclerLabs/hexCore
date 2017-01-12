package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
abstract MessageType( String )
{
	inline public function new( ?name : String = "handleMessage" ) 
	{
		this = name;
	}

	@:from public static inline function fromString( s : String ) : MessageType
	{
		return new MessageType( s );
	}
	
	@:to public inline function toString() : String
	{
		return this;
	}
}