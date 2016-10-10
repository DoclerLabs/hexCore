package hex.event;

import hex.event.MessageType;

/**
 * ...
 * @author Heorhiy Kharvat
 */
class TypedMessageType<T> extends MessageType
{
	public function new( ?messageName : String ) 
	{
		super(messageName);
	}
}