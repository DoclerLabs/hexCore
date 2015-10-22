package hex.log;

import hex.event.IEventListener;

/**
 * ...
 * @author Francis Bourre
 */
interface ILogListener extends IEventListener
{
    /**
	 * Triggered when a Log event is dispatched by the Logging API.
	 *
	 * @param       e       LogEvent event
	 *
	 * @see Logger
	 */
    public function onLog( e : LogEvent ) : Void;
}
