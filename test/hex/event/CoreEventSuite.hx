package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @suite("Event")
    public var list : Array<Class<Dynamic>> = [DynamicDispatcherTest, BasicEventTest, CompositeClosureDispatcherTest, EventDispatcherTest, LightweightListenerDispatcherTest, LightweightClosureDispatcherTest];
}
