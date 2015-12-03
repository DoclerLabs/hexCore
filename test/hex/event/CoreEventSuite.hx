package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @suite("Event suite")
    public var list : Array<Class<Dynamic>> = [BasicEventTest, CompositeClosureDispatcherTest, EventDispatcherTest, LightweightListenerDispatcherTest, LightweightClosureDispatcherTest];
}
