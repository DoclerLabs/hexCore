package hex.log.layout;

import haxe.PosInfos;
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
		var posInfos : PosInfos = message.posInfos;
		var info : String = posInfos != null ? " at " + posInfos.className + "::" + posInfos.methodName + " line " + posInfos.lineNumber + " in file " + posInfos.fileName : "";
		var m : haxe.extern.Rest<Dynamic>->Void;
		
		if ( message.level.value == LogLevel.DEBUG.value )
		{
			m = Browser.console.debug;
		}
		else if ( message.level.value == LogLevel.INFO.value )
		{
			m = Browser.console.info;
		}
		else if ( message.level.value == LogLevel.WARN.value )
		{
			m = Browser.console.warn;
		}
		else if ( message.level.value == LogLevel.FATAL.value || message.level.value == LogLevel.ERROR.value)
		{
			m = Browser.console.error;
				
		}
		else
		{
			m = Browser.console.log;
		}
		
		m( message.message, "[" + message.domain.getName() + "]" + info );
	}
	
	public function onClear() : Void 
	{
		Browser.console.clear();
	}
}