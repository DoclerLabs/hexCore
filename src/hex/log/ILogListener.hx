package hex.log;

/**
 * ...
 * @author Francis Bourre
 */
interface ILogListener
{
	function onClear() : Void;
	
    /**
	 * Triggered when a Log event is dispatched by the Logging API.
	 * @see Logger
	 */
    function onLog( message : LoggerMessage ) : Void;
}