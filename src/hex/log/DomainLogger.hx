package hex.log;

import haxe.PosInfos;
import hex.domain.Domain;
import hex.error.NullPointerException;
import hex.log.Logger;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class DomainLogger implements ILogger
{
	var _domain		: Domain;
	var _logger		: Logger;

	public function new( domain : Domain ) 
	{
		if ( domain == null )
		{
				throw new NullPointerException( "Domain should be specified for contructor call" );
		}
		
		this._domain = domain;
		this._logger = Logger.getInstance();
	}
	
	public function clear() : Void
	{
		this._logger.clear();
	}
	
	public function debug( o : Dynamic, ?posInfos : PosInfos ) : Void
	{
		this._logger.log( o, LogLevel.DEBUG, this._domain, posInfos );
	}
	
	public function info( o : Dynamic, ?posInfos : PosInfos ) : Void
	{
		this._logger.log( o, LogLevel.INFO, this._domain, posInfos );
	}
	
	public function warn( o : Dynamic, ?posInfos : PosInfos ) : Void
	{
		this._logger.log( o, LogLevel.WARN, this._domain, posInfos );
	}
	
	public function error( o : Dynamic, ?posInfos : PosInfos ) : Void
	{
		this._logger.log( o, LogLevel.ERROR, this._domain, posInfos );
	}
	
	public function fatal( o : Dynamic, ?posInfos : PosInfos ) : Void
	{
		this._logger.log( o, LogLevel.FATAL, this._domain, posInfos );
	}
	
	public function getDomain() : Domain
	{
		return this._domain;
	}
}