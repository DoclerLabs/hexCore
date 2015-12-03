package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @suite("Event suite")
    public var list : Array<Class<Dynamic>> = [BasicEventTest, CompositeDispatcherTest, EventDispatcherTest, LightweightListenerDispatcherTest, LightweightClosureDispatcherTest];
}
