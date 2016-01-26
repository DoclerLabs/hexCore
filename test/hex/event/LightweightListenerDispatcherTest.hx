package hex.event;

import hex.error.UnsupportedOperationException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightListenerDispatcherTest
{
	var _dispatcher   : LightweightListenerDispatcher<IMockEventListener, BasicEvent>;
    var _listener     : MockEventListener;

    @Before
    public function setUp() : Void
    {
        this._dispatcher    = new LightweightListenerDispatcher<IMockEventListener, BasicEvent>();
        this._listener      = new MockEventListener();
    }

    @After
    public function tearDown() : Void
    {
        this._dispatcher    = null;
        this._listener      = null;
    }
	
	@Test( "Test 'addListener' behavior" )
    public function testAddListener() : Void
    {
        Assert.isTrue( this._dispatcher.addListener( this._listener ), "'addListener' call should return true" );
        Assert.isFalse( this._dispatcher.addListener( this._listener ), "Same 'addListener' calls should return false second time" );
        var event = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 1, "Event should be received once" );
        Assert.equals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }

    @Test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.removeListener( this._listener ), "'removeListener' call should return true" );

        var event = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
        Assert.isFalse( this._dispatcher.removeListener( this._listener ), "Same 'removeListener' call should return false second time" );
    }
	
	@Test( "Test 'addEventListener' behavior" )
    public function testAddEventListener() : Void
    {
        Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.addEventListener, [ "onEvent", this._listener.onEvent ], "'addEventListener' should throw UnsupportedOperationException" );
    }
	
	@Test( "Test 'removeEventListener' behavior" )
    public function testRemoveEventListener() : Void
    {
        Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.removeEventListener, [ "onEvent", this._listener.onEvent ], "'removeEventListener' should throw UnsupportedOperationException" );
    }
	
	@Test( "Test 'isEmpty' behavior with 'addListener'" )
    public function testIsEmptyWithAddListener() : Void
    {
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addListener( this._listener );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeListener( this._listener );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }
	
	@Test( "Test 'dispatchEvent' behavior" )
    public function testDispatchEvent() : Void
    {
        var dispatcher = new LightweightListenerDispatcher<IEventListener, BasicEvent>();
        var mockListener = new MockListener();
        dispatcher.addListener( mockListener );

        var event = new BasicEvent( "onEvent", dispatcher );
        dispatcher.dispatchEvent( event );

        Assert.equals( mockListener.eventReceivedCount, 1, "Event should be received once" );
        Assert.equals( mockListener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent = new BasicEvent( "onEvent", this._dispatcher );
        dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( mockListener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( mockListener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
	}
	
	@Test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
        this._dispatcher.addListener( this._listener );
        var event = new BasicEvent( "onEvent", this._dispatcher );

        this._dispatcher.removeAllListeners();
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatchEvent( event );
        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
    }
	
	@Test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
        Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
    }
	
	@Test( "Test 'hasEventListener' behavior" )
    public function testHasEventListener() : Void
    {
        Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.hasEventListener, [ "onEvent", this._listener.onEvent ], "'hasEventListener' should throw UnsupportedOperationException" );
	}
	
	@Test( "Test seal activation on 'removeListener' during dispatching" )
    public function testSealActivationOnRemoveListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveListener( this._listener );
		this._dispatcher.addListener( mockEventListener );
		this._dispatcher.addListener( this._listener );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
	}
	
	@Test( "Test seal activation on 'addListener' during dispatching" )
    public function testSealActivationOnAddListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnAddListener( this._listener );
		this._dispatcher.addListener( mockEventListener );
		var mockListener = new MockEventListener();
		this._dispatcher.addListener( mockListener );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 0, this._listener.eventReceivedCount, "Event shouldn't be received" );
		Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
	}
	
	@Test( "Test seal activation on 'removeAllListeners' during dispatching" )
    public function testSealActivationOnRemoveAllListeners() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveAllListeners();
		this._dispatcher.addListener( mockEventListener );
		this._dispatcher.addListener( this._listener );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
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

private class MockEventListenerForTestingSealingOnRemoveListener extends MockEventListener
{
    public var listener : IMockEventListener;

    public function new( listener : IMockEventListener )
    {
		super();
		this.listener = listener;
    }

    override public function onEvent( e : BasicEvent ) : Void
    {
        super.onEvent( e );
		e.target.removeListener( listener );
    }
}

private class MockEventListenerForTestingSealingOnAddListener extends MockEventListener
{
    public var listener : IMockEventListener;

    public function new( listener : IMockEventListener )
    {
		super();
		this.listener = listener;
    }

    override public function onEvent( e : BasicEvent ) : Void
    {
        super.onEvent( e );
		e.target.addListener( listener );
    }
}

private class MockEventListenerForTestingSealingOnRemoveAllListeners extends MockEventListener
{
    public function new()
    {
		super();
    }

    override public function onEvent( e : BasicEvent ) : Void
    {
        super.onEvent( e );
		e.target.removeAllListeners();
    }
}