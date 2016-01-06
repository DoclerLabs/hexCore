package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class MessageType
{
	public var messageName( default, null ) : String;
	
	public function new( ?messageName : String = "handleMessage" ) 
	{
		this.messageName = messageName;
	}
}