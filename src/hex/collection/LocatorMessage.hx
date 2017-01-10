package hex.collection;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessage
{
	inline static public var REGISTER	= new MessageType( "onRegister" );
	inline static public var UNREGISTER	= new MessageType( "onUnregister" );

	function new() 
	{
		
	}
}