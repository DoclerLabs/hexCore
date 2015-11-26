package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CoreEventSuite
{
    @suite("Event suite")
    public var list : Array<Class<Dynamic>> = [EventDispatcherTest, LightweightListenerDispatcherTest, LightweightClosureDispatcherTest, BasicEventTest];
}
