package hex.log;

import hex.domain.Domain;

/**
 * ...
 * @author Francis Bourre
 */
interface ILogListener
{
    /**
	 * Triggered when a Log event is dispatched by the Logging API.
	 * @see Logger
	 */
    public function onLog( message : Dynamic, level : LogLevel, domain : Domain ) : Void;
}