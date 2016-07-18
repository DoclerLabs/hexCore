package hex.log.layout;

import haxe.Log;
import haxe.PosInfos;
import hex.log.ILogListener;
import hex.log.LoggerMessage;

/**
 * ...
 * @author Francis Bourre
 */
class TraceLayout implements ILogListener
{
	public function new() 
	{
		
	}

	public function onLog( message : LoggerMessage ) : Void 
	{
		var posInfos : PosInfos = message.posInfos;
		var info : String = posInfos != null ? " at " + posInfos.className + "::" + posInfos.methodName + " line " + posInfos.lineNumber + " in file " + posInfos.fileName : "";
		
		Log.trace( ">>> " + message.level + ":" + message.message + " [" + message.domain.getName() + "]" + info, posInfos );
	}
	
	public function onClear() : Void 
	{
		#if (flash || js)
		Log.clear();
		#end
	}
}
