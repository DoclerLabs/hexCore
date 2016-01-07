package hex.log;

import hex.domain.Domain;
import hex.domain.NewDomainDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class Logger
{
	private static var _Instance 	: Logger = null;
	
    private var _dispatcher 		: NewDomainDispatcher<ILogListener>;
    private var _level 		    	: LogLevel;

    public function new()
    {
        this.setLevel( LogLevel.ALL );
        this._dispatcher = new NewDomainDispatcher<ILogListener>();
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

    public function log( o : Dynamic, level : LogLevel, ?domain : Domain) : Void
    {
        this._dispatcher.dispatch( LoggerMessage.LOG, domain, [ o, level, domain ] );
    }

    public function addLogListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.addHandler( LoggerMessage.LOG, listener, listener.onLog, domain );
    }

    public function removeLogListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.removeHandler( LoggerMessage.LOG, listener, listener.onLog, domain );
    }

    public function isRegistered( listener : ILogListener, ?domain : Domain ) : Bool
    {
        return this._dispatcher.isRegistered( listener, LoggerMessage.LOG, domain );
    }

    public function removeAllListeners() : Void
    {
        this._dispatcher.removeAllListeners();
    }

    public function toString() : String
    {
        return Stringifier.stringify( this );
    }
	
	public static function DEBUG( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Void
	{
		Logger.getInstance().log( o, LogLevel.DEBUG, domain );
	}
	
	public static function INFO( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Void
	{
		Logger.getInstance().log( o, LogLevel.INFO, domain );
	}
	
	public static function WARN( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Void
	{
		Logger.getInstance().log( o, LogLevel.WARN, domain );
	}
	
	public static function ERROR( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Void
	{
		Logger.getInstance().log( o, LogLevel.ERROR, domain );
	}
	
	public static function FATAL( o : Dynamic, ?domain : Domain, ?target : Dynamic ) : Void
	{
		Logger.getInstance().log( o, LogLevel.FATAL, domain );
	}
}
