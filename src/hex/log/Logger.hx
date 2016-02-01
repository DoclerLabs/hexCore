package hex.log;

import hex.domain.Domain;
import hex.domain.DomainDispatcher;
import hex.domain.NoDomain;

/**
 * ...
 * @author Francis Bourre
 */
class Logger
{
	static var _Instance 	: Logger = null;
	
    var _dispatcher 		: DomainDispatcher<ILogListener>;
    var _level 		    	: LogLevel;

    public function new()
    {
        this.setLevel( LogLevel.ALL );
        this._dispatcher = new DomainDispatcher<ILogListener>();
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
	
	public function clear() : Void
    {
        this._dispatcher.dispatch( LoggerMessage.CLEAR  );
    }

    public function log( o : Dynamic, level : LogLevel, ?domain : Domain) : Void
    {
        if ( this._level.value <= level.value )
		{
			this._dispatcher.dispatch( LoggerMessage.LOG, domain, [ new LoggerMessage( o, level, domain == null ? NoDomain.DOMAIN : domain ) ] );
		}
    }

    public function addListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        this._dispatcher.addHandler( LoggerMessage.LOG, listener, listener.onLog, domain );
        return this._dispatcher.addHandler( LoggerMessage.CLEAR, listener, listener.onClear, domain );
    }

    public function removeListener( listener : ILogListener, ?domain : Domain ) : Bool
    {
        this._dispatcher.removeHandler( LoggerMessage.LOG, listener, listener.onLog, domain );
        return this._dispatcher.removeHandler( LoggerMessage.CLEAR, listener, listener.onClear, domain );
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
	
	public static function DEBUG( o : Dynamic, ?domain : Domain ) : Void
	{
		Logger.getInstance().log( o, LogLevel.DEBUG, domain );
	}
	
	public static function INFO( o : Dynamic, ?domain : Domain ) : Void
	{
		Logger.getInstance().log( o, LogLevel.INFO, domain );
	}
	
	public static function WARN( o : Dynamic, ?domain : Domain ) : Void
	{
		Logger.getInstance().log( o, LogLevel.WARN, domain );
	}
	
	public static function ERROR( o : Dynamic, ?domain : Domain ) : Void
	{
		Logger.getInstance().log( o, LogLevel.ERROR, domain );
	}
	
	public static function FATAL( o : Dynamic, ?domain : Domain ) : Void
	{
		Logger.getInstance().log( o, LogLevel.FATAL, domain );
	}
	
	public static function CLEAR( ?domain : Domain )  : Void
	{
		Logger.getInstance().clear();
	}
}
