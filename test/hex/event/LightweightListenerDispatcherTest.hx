package hex.event;

import hex.error.UnsupportedOperationException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightListenerDispatcherTest
{
	private var _dispatcher   : LightweightListenerDispatcher<IMockEventListener, BasicEvent>;
    private var _listener     : MockEventListener;

    @setUp
    public function setUp() : Void
    {
        this._dispatcher    = new LightweightListenerDispatcher<IMockEventListener, BasicEvent>();
        this._listener      = new MockEventListener();
    }

    @tearDown
    public function tearDown() : Void
    {
        this._dispatcher    = null;
        this._listener      = null;
    }
	
	@test( "Test 'addListener' behavior" )
    public function testAddListener() : Void
    {
        Assert.assertTrue( this._dispatcher.addListener( this._listener ), "'addListener' call should return true" );
        Assert.failTrue( this._dispatcher.addListener( this._listener ), "Same 'addListener' calls should return false second time" );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.assertEquals( this._listener.eventReceivedCount, 1, "Event should be received once" );
        Assert.assertEquals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.assertEquals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.assertEquals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }

    @test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
        this._dispatcher.addListener( this._listener );
        Assert.assertTrue( this._dispatcher.removeListener( this._listener ), "'removeListener' call should return true" );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.assertEquals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.assertIsNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
        Assert.failTrue( this._dispatcher.removeListener( this._listener ), "Same 'removeListener' call should return false second time" );
    }
	
	@test( "Test 'addEventListener' behavior" )
    public function testAddEventListener() : Void
    {
        Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.addEventListener, [ "onEvent", this._listener.onEvent ], "'addEventListener' should throw UnsupportedOperationException" );
    }
	
	@test( "Test 'removeEventListener' behavior" )
    public function testRemoveEventListener() : Void
    {
        Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.removeEventListener, [ "onEvent", this._listener.onEvent ], "'removeEventListener' should throw UnsupportedOperationException" );
    }
	
	@test( "Test 'isEmpty' behavior with 'addListener'" )
    public function testIsEmptyWithAddListener() : Void
    {
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addListener( this._listener );
        Assert.failTrue( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeListener( this._listener );
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }
	
	@test( "Test 'dispatchEvent' behavior" )
    public function testDispatchEvent() : Void
    {
        var dispatcher : LightweightListenerDispatcher<IEventListener, BasicEvent> = new LightweightListenerDispatcher<IEventListener, BasicEvent>();
        var mockListener : MockListener = new MockListener();
        dispatcher.addListener( mockListener );

        var event : BasicEvent = new BasicEvent( "onEvent", dispatcher );
        dispatcher.dispatchEvent( event );

        Assert.assertEquals( mockListener.eventReceivedCount, 1, "Event should be received once" );
        Assert.assertEquals( mockListener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        dispatcher.dispatchEvent( anotherEvent );

        Assert.assertEquals( mockListener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.assertEquals( mockListener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
	}
	
	@test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
        this._dispatcher.addListener( this._listener );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );

        this._dispatcher.removeAllListeners();
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatchEvent( event );
        Assert.assertEquals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.assertIsNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
    }
	
	@test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
        Assert.failTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.assertTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
    }
	
	@test( "Test 'hasEventListener' behavior" )
    public function testHasEventListener() : Void
    {
        Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.hasEventListener, [ "onEvent", this._listener.onEvent ], "'hasEventListener' should throw UnsupportedOperationException" );
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

private class MockListener implements IEventListener
{
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : BasicEvent = null;

    public function new()
    {

    }

    public function handleEvent( e : IEvent ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = cast e;
    }
}