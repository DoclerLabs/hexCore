package hex.util;

/**
 * ...
 * @author duke
 */
class PerformanceUtil
{
	static var timers = new Map<String,PerformanceVO>();

	/**
	 * Start speed test.
	 * @param	name Name of test.
	 */
	public static function startTimer( name : String = "test" ) : Void
	{
		PerformanceUtil.timers[ name ] = new PerformanceVO( Date.now().getTime(), getMemory() );
		trace( "*** TEST STARTED:  " + name + " ***" );
	}
	
	/**
	 * Stop speed test. It outputs the result
	 * @param	name The name of started test.
	 */
	public static function stopTimer( name : String = "test") : Void
	{
		if ( PerformanceUtil.timers[ name ] != null )
		{
			trace( 	"*** TEST FINISHED: " + name + "  time: " + 
					( Date.now().getTime() - PerformanceUtil.timers[ name ].startTime ) + " ms  memory: " + 
					( Math.round( ( PerformanceUtil.getMemory() - PerformanceUtil.timers[ name ].memory ) / 1024 * 100) / 100 ) + " KB ***" );
					
			PerformanceUtil.timers.remove( name );
		}
		else
		{
			trace( "*** NO TEST FOUND: " + name + " ***" );
		}
	}
	
	static function getMemory( ):Float
	{
		#if flash
			return flash.system.System.totalMemory;
		#elseif js
			if ( Reflect.hasField(js.Browser.window, "performance" ) )
			{
				var perf:Dynamic = Reflect.field(js.Browser.window, "performance" );
				return  Reflect.hasField(perf, "memory") ? Reflect.field(Reflect.field( perf, "memory"), "totalJSHeapSize") : null; //usedJSHeapSize
			}
			else
			{
				return null;
			}
		#else
			return null;
		#end
	}
	
}

private class PerformanceVO
{
	public var memory		: Float;
	public var startTime	: Float;
	
	public function new( startTime : Float, memory : Float )
	{
		this.startTime 	= startTime;
		this.memory 	= memory;
	}
}