package hex.log;

import hex.domain.Domain;
import hex.domain.DomainDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class Logger
{
	private static var _Instance 	: Logger = null;
	
    private var _dispatcher 		: DomainDispatcher<ILogListener, LogEvent>;
    private var _level 		    	: LogLevel;

    public function new()
    {
        this.setLevel( LogLevel.ALL );
        this._dispatcher = new DomainDispatcher<ILogListener, LogEvent>();
    }
	
	public static function getInstance() : Logger
	{
		if ( Logger._Instance == null ) 
		{
			Logger._Instance = new Logger();
		}
		
		return Logger._Instance;
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
	
	public static function LOG( o : Dynamic, level : LogLevel, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.getInstance().log( new LogEvent( level, target != null ? target : Logger.getInstance(), o ), domain );
	}
	
	public static function DEBUG( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.LOG( o, LogLevel.DEBUG, domain, target );
	}
	
	public static function INFO( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.LOG( o, LogLevel.INFO, domain, target );
	}
	
	public static function WARN( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.LOG( o, LogLevel.WARN, domain, target );
	}
	
	public static function ERROR( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.LOG( o, LogLevel.ERROR, domain, target );
	}
	
	public static function FATAL( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Bool
	{
		return Logger.LOG( o, LogLevel.FATAL, domain, target );
	}
}
