package hex.collection;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessage
{
	static public var REGISTER		= new MessageType( "onRegister" );
	static public var UNREGISTER	= new MessageType( "onUnregister" );

	function new() 
	{
		
	}
}