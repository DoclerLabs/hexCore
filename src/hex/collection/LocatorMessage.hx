package hex.collection;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessage
{
	/** @private */ function new() throw new hex.error.PrivateConstructorException();
	inline static public var REGISTER	= new MessageType( "onRegister" );
	inline static public var UNREGISTER	= new MessageType( "onUnregister" );
}