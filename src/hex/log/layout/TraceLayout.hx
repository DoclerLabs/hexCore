package hex.log.layout;

import hex.domain.Domain;
import hex.log.ILogListener;

/**
 * ...
 * @author Francis Bourre
 */
class TraceLayout implements ILogListener
{
	public function new() 
	{
		
	}

	public function onLog( message : Dynamic, level : LogLevel, ?domain : Domain ) : Void 
	{
		trace( ">>> " + level + ":" + message );
	}
	
	public function onClear( ?domain : Domain ) : Void 
	{
		trace( "Clear..." );
	}
}