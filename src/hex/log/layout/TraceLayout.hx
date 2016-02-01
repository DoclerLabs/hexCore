package hex.log.layout;

import hex.log.ILogListener;
import hex.log.LoggerMessage;

/**
 * ...
 * @author Francis Bourre
 */
class TraceLayout implements ILogListener
{
	public function new() 
	{
		
	}

	public function onLog( message : LoggerMessage ) : Void 
	{
		trace( ">>> " + message.level + ":" + message );
	}
	
	public function onClear() : Void 
	{
		trace( "Clear..." );
	}
}