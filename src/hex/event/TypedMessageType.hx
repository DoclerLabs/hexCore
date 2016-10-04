package hex.event;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class TypedMessageType<T> extends MessageType
{
	public function new( ?messageName : String ) 
	{
		super(messageName);
	}
}