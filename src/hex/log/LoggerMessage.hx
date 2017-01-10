package hex.log;

import haxe.PosInfos;
import hex.domain.Domain;
import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class LoggerMessage
{
	inline public static var LOG 	= new MessageType( "onLog" );
	inline public static var CLEAR = new MessageType( "onClear" );
	
	public var message 	: Dynamic;
	public var level 	: LogLevel;
	public var domain 	: Domain;
	public var posInfos : PosInfos;
	
	public function new( message : Dynamic, level : LogLevel, ?domain : Domain, ?posInfos : PosInfos ) 
	{
		this.message 	= message;
		this.level 		= level;
		this.domain 	= domain;
		this.posInfos 	= posInfos;
	}
}