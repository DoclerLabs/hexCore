package hex.event;

import hex.event.MessageType;

/**
 * ...
 * @author Heorhiy Kharvat
 */
abstract TypedMessageType<T>( MessageType )
{
	inline public function new( ?name : MessageType )
	{
		if ( name == null ) {
			this = new MessageType( "handleMessage" );
		} else {
			this = name;
		}
	}

	@:to public inline function toMessageType() : MessageType
	{
		return this;
	}

	@:to public inline function toString() : String
	{
		return this;
	}
}