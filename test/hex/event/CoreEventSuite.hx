package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @Suite( "Event" )
    public var list : Array<Class<Dynamic>> 
	= [	
		BasicEventTest, 
		ClosuredispatcherTest, 
		CompositeDispatcherTest, 
		DispatcherTest, 
		FullClosureDispatcherTest, 
		MonoTypeClosureDispatcherTest,
		TriggerTest
	];
}
