package hex.log.layout;

import hex.log.ILogListener;
import hex.log.LoggerMessage;
import js.Browser;

/**
 * ...
 * @author Francis Bourre
 */
class JavaScriptConsoleLayout implements ILogListener
{
	public function new() 
	{
		
	}

	public function onLog( message : LoggerMessage ) : Void 
	{
		if ( message.level == LogLevel.DEBUG )
		{
			Browser.console.debug( message.message, " [" + message.domain.getName() + "]" );
		}
		else if ( message.level == LogLevel.WARN )
		{
			Browser.console.warn( message.message, " [" + message.domain.getName() + "]" );
		}
		else if ( message.level == LogLevel.FATAL || message.level == LogLevel.ERROR )
		{
			Browser.console.error( message.message, " [" + message.domain.getName() + "]" );
		}
		else
		{
			Browser.console.log( message.message, " [" + message.domain.getName() + "]" );
		}
	}
	
	public function onClear() : Void 
	{
		Browser.console.clear( );
	}
}