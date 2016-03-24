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
	private var _leftSearchSeparator	: String;
	private var _rightSearchSeparator	: String;
	
	var _dispatcher 			: LogProxyLayoutDispatcher;
	var _messages 				: Array<LoggerMessage>;
	var _filteredLevel			: LogLevel;
	var _filteredDomain			: Domain;
	
	var _searchedWord			: String = "";
	
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
		this._render();
	}
	
	public function searchFor( word : String = "", leftSearchSeparator : String, rightSearchSeparator : String ) : Int
	{
		this._searchedWord 			= word;
		this._leftSearchSeparator 	= leftSearchSeparator;
		this._rightSearchSeparator 	= rightSearchSeparator;
		this._dispatcher.onClear();
		
		return this._render();
	}
	
	function _render() : Int
	{
		var searchLength : Int = 0;
		
		for ( message in this._messages )
		{
			if ( ( this._filteredDomain == AllDomain.DOMAIN || this._filteredDomain == message.domain) &&
				( this._filteredLevel == LogLevel.ALL || this._filteredLevel == message.level ) )
			{
				var messageContent : String = "" + message.message;
				if ( this._searchedWord.length > 0 && messageContent.indexOf( this._searchedWord ) != -1 )
				{
					messageContent = ( messageContent.split( this._searchedWord ) )
					.join( this._getLeftSeparator( searchLength, this._leftSearchSeparator ) + this._searchedWord + this._rightSearchSeparator );
					searchLength++;
				}
				this._dispatcher.onLog( new LoggerMessage( messageContent, message.level, message.domain, message.posInfos ) );
			}
		}
		
		return searchLength;
	}
	
	function _getLeftSeparator( index : Int, separator : String ) : String
	{
		return separator.split( ">" ).join( " id='searchedWord" + index ) + "'>";
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