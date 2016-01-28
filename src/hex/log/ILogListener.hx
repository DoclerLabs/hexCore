package hex.log;

import hex.domain.Domain;

/**
 * ...
 * @author Francis Bourre
 */
interface ILogListener
{
	function onClear( ?domain : Domain ) : Void;
	
    /**
	 * Triggered when a Log event is dispatched by the Logging API.
	 * @see Logger
	 */
    function onLog( message : Dynamic, level : LogLevel, ?domain : Domain ) : Void;
}