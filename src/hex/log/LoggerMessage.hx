package hex.log;

import hex.domain.Domain;
import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LoggerMessage
{
	public static var LOG 	= new MessageType( "onLog" );
	public static var CLEAR = new MessageType( "onClear" );
	
	public var message 	: Dynamic;
	public var level 	: LogLevel;
	public var domain 	: Domain;
	
	public function new( message : Dynamic, level : LogLevel, ?domain : Domain ) 
	{
		this.message 	= message;
		this.level 		= level;
		this.domain 	= domain;
	}
}