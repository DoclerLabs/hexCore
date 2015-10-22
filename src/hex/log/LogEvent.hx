package hex.log;

import hex.domain.Domain;
import hex.event.BasicEvent;

/**
 * ...
 * @author Francis Bourre
 */
class LogEvent extends BasicEvent
{
    /**
	 * @eventType onLog
	 */
    public static inline var onLogEVENT : String = "onLog";

    /**
	 * Log level
	 */
    public var level : LogLevel;

    /**
	 * Message
	 */
    public var message : Dynamic;

    /**
	 * Domain used by this event.
	 */
    public var domain : Domain;

    /**
	 * Creates instance.
	 *
	 * @param       level   LogLevel status
	 * @param       message Message to send
	 */
    public function new( level : LogLevel, logger : Logger, message : Dynamic )
    {
        super( LogEvent.onLogEVENT, logger );

        this.level = level;
        this.message = message;
    }

    /**
	 * Duplicates this instance
	 * @return      A new Event object that is identical to the original.
	 */
    override public function clone() : BasicEvent
    {
        return new LogEvent( this.level, this.target, this.message );
    }
}
