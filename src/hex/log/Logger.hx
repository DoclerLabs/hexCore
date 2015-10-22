package hex.log;

import hex.domain.Domain;
import hex.domain.DomainDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class Logger
{
    private var _dispatcher 	: DomainDispatcher<ILogListener, LogEvent>;
    private var _level 		    : LogLevel;

    public function new()
    {
        this.setLevel( LogLevel.ALL );
        this._dispatcher = new DomainDispatcher<ILogListener, LogEvent>();
    }

    public function setLevel( level : LogLevel ) : Void
    {
        this._level = level;
    }

    public function getLevel() : LogLevel
    {
        return this._level;
    }

    public function log( e : LogEvent, ?domain : Domain ) : Bool
    {
        if ( e.level.value >= this._level.value )
        {
            if ( domain != null )
            {
                e.domain = domain;
            }

            this._dispatcher.dispatchEvent( e, domain );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function addLogListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.addEventListener( LogEvent.onLogEVENT, listener.onLog, domain );
    }

    public function removeLogListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.removeEventListener( LogEvent.onLogEVENT, listener.onLog, domain );
    }

    public function isRegistered( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.isRegistered( listener, LogEvent.onLogEVENT, domain );
    }

    public function removeAllListeners() : Void
    {
        this._dispatcher.removeAllListeners();
    }

    public function toString() : String
    {
        return Stringifier.stringify( this );
    }
}
