package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CompositeDispatcherTest
{

	private var _dispatcher : CompositeClosureDispatcher<IMockEventListener, BasicEvent>;
	private var _listener 	: MockEventListener;
	
	@setUp
    public function setUp() : Void
    {
        this._dispatcher    = new CompositeClosureDispatcher<IMockEventListener, BasicEvent>();
        this._listener      = new MockEventListener();
    }

    @tearDown
    public function tearDown() : Void
    {
        this._dispatcher    = null;
        this._listener      = null;
    }
	
}

private interface IMockEventListener extends IEventListener
{
    function onEvent( e : BasicEvent ) : Void;
}

private class MockEventListener implements IMockEventListener
{
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : BasicEvent = null;

    public function new()
    {

    }

    public function onEvent( e : BasicEvent ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = e;
    }
	
	public function handleEvent( e : IEvent ) : Void
    {
		this.eventReceivedCount++;
        this.lastEventReceived = cast e;
	}
}