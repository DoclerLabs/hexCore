package hex.log.layout;

import hex.event.IEvent;
import hex.log.ILogListener;
import hex.log.LogEvent;

/**
 * ...
 * @author Francis Bourre
 */
class TraceLayout implements ILogListener
{
	public function new() 
	{
		
	}

	public function onLog( e : LogEvent ) : Void 
	{
		trace( ">>> " + e.level + ":" + e.message );
	}
	
	public function handleEvent( e : IEvent ) : Void 
	{
		
	}
}