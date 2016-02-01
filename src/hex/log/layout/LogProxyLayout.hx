package hex.log.layout;

import hex.domain.Domain;
import hex.domain.DomainUtil;
import hex.log.ILogListener;
import hex.log.LogLevel;
import hex.log.LoggerMessage;
import hex.model.ModelDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class LogProxyLayout implements ILogListener
{
	var _dispatcher 		: LogProxyLayoutDispatcher;
	var _messages 			: Array<LoggerMessage>;
	var _filteredLevel		: LogLevel;
	var _filteredDomain		: Domain;
	
	public function new() 
	{
		this._dispatcher 		= new LogProxyLayoutDispatcher();
		this._messages			= [];

		this._filteredLevel 	= LogLevel.ALL;
		this._filteredDomain 	= AllDomain.DOMAIN;

		Logger.getInstance().addListener( this );
	}
	
	public function onClear() : Void 
	{
		this._dispatcher.onClear();
	}
	
	public function onLog( message : LoggerMessage ) : Void 
	{
		//Create message
		this._messages.push( message );
		
		//Dispatch message
		if ( ( this._filteredDomain == AllDomain.DOMAIN || this._filteredDomain == message.domain) &&
				( this._filteredLevel == LogLevel.ALL || this._filteredLevel == message.level ) )
		{
			this._dispatcher.onLog( message );
		}
	}
	
	public function addListener( listener : ILogListener ) : Bool
	{
		return this._dispatcher.addListener( listener );
	}
	
	public function removeListener( listener : ILogListener) : Bool
	{
		return this._dispatcher.removeListener( listener );
	}
	
	public function filter( ?level : LogLevel, ?domain : Domain ) : Void
	{
		this._filteredLevel 	= level == null ? LogLevel.ALL : level;
		this._filteredDomain 	= domain == null ? AllDomain.DOMAIN : domain;
		
		this._dispatcher.onClear();
		
		for ( message in this._messages )
		{
			if ( ( this._filteredDomain == AllDomain.DOMAIN || this._filteredDomain == message.domain) &&
				( this._filteredLevel == LogLevel.ALL || this._filteredLevel == message.level ) )
			{
				this._dispatcher.onLog( message );
			}
		}
	}
}

class AllDomain extends Domain
{
    public static var DOMAIN : AllDomain = DomainUtil.getDomain( "AllDomain", AllDomain );
}

class LogProxyLayoutDispatcher extends ModelDispatcher<ILogListener> implements ILogListener
{
	public function new() 
	{
		super();
	}
	
	public function onClear() : Void 
	{
		
	}
	
	public function onLog( message : LoggerMessage ) : Void 
	{
		
	}
}