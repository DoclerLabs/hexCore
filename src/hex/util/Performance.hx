package hex.util;
import haxe.ds.HashMap;

/**
 * ...
 * @author duke
 */
class Performance
{
	private static var timers:Map<String,PerformanceVO> = new Map<String,PerformanceVO>();

	/**
	 * Start speed test.
	 * @param	name Name of test.
	 */
	public static function startTimer(name:String = "test"):Void
	{
		
		
		timers[name] = new PerformanceVO( Date.now().getTime(), getMemory() );
		trace( "*** TEST STARTED:  " + name + " ***" );
	}
	
	/**
	 * Stop speed test. It outputs the result
	 * @param	name The name of started test.
	 */
	public static function stopTimer(name:String = "test"):Void
	{
		if ( timers[name] != null )
		{
			trace( "*** TEST FINISHED: " + name + "  time: " + ( Date.now().getTime() - timers[name].startTime ) + " ms  memory: " + (Math.round((getMemory() - timers[name].memory) / 1024 * 100) / 100) + " KB ***" );
			timers.remove(name);
		}
		else
		{
			trace( "*** NO TEST FOUND: " + name + " ***" );
		}
	}
	
	private static function getMemory( ):Float
	{
		#if flash
			return flash.system.System.totalMemory;
		#elseif js
			return js.Browser.window.performance && js.Browser.window.performance.memory ? js.Browser.window.performance.memory.totalJSHeapSize; //usedJSHeapSize
		#else
			return null;
		#end
	}
	
}

private class PerformanceVO
{
	public var memory:Float;
	public var startTime:Float;
	
	public function new( startTime:Float, memory:Float )
	{
		this.startTime = startTime;
		this.memory = memory;
	}
}