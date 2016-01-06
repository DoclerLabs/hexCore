package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class MessageType
{
	public var name( default, null ) : String;
	
	public function new( ?messageName : String = "handleMessage" ) 
	{
		this.name = messageName;
	}
}