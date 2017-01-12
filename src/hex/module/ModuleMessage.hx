package hex.module;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class ModuleMessage
{
	inline public static var INITIALIZED       = new MessageType( "onModuleInitialisation" );
    inline public static var RELEASED          = new MessageType( "onModuleRelease" );
	
	function new() 
	{
		
	}
}