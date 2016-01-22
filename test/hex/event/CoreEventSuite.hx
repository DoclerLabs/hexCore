package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @Suite("Event")
    public var list : Array<Class<Dynamic>> = [DynamicDispatcherTest, BasicEventTest, CompositeClosureDispatcherTest, DispatcherTest, EventDispatcherTest, LightweightListenerDispatcherTest, LightweightClosureDispatcherTest];
}
