package hex.log;

import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LoggerMessage
{
	public static var LOG 	= new MessageType( "onLog" );
	public static var CLEAR = new MessageType( "onClear" );
	
	function new() 
	{
		
	}
}