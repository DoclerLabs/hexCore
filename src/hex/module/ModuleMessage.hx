package hex.module;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class ModuleMessage
{
	public static var INITIALIZED       = new MessageType( "onModuleInitialisation" );
    public static var RELEASED          = new MessageType( "onModuleRelease" );
	
	function new() 
	{
		
	}
}