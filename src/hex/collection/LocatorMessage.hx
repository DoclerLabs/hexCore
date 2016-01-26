package hex.collection;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessage
{
	static public var REGISTER		: MessageType = new MessageType( "onRegister" );
	static public var UNREGISTER	: MessageType = new MessageType( "onUnregister" );

	function new() 
	{
		
	}
}