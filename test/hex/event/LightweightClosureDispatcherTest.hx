package hex.event;

import hex.error.UnsupportedOperationException;
import hex.event.IEvent;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightClosureDispatcherTest
{
    var _dispatcher   : LightweightClosureDispatcher<BasicEvent>;
    var _listener     : MockEventListener;

    @Before
    public function setUp() : Void
    {
        this._dispatcher    = new LightweightClosureDispatcher();
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
        Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.addListener, [ this._listener ], "addListener should throw UnsupportedOperationException" );
    }
	
	@Test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
        Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.removeListener, [ this._listener ], "removeListener should throw UnsupportedOperationException" );
    }
	
	@Test( "Test 'addEventListener' behavior" )
    public function testAddEventListener() : Void
    {
        Assert.isTrue( this._dispatcher.addEventListener( "onEvent", this._listener.onEvent ), "'addEventListener' call should return true" );
        Assert.isFalse( this._dispatcher.addEventListener( "onEvent", this._listener.onEvent ), "Same 'addEventListener' calls should return false second time" );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 1, "Event should be received once" );
        Assert.equals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }
	
	@Test( "Test 'removeEventListener' behavior" )
    public function testRemoveEventListener() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.isTrue( this._dispatcher.removeEventListener( "onEvent", this._listener.onEvent ), "'removeEventListener' call should return true" );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
        Assert.isFalse( this._dispatcher.removeEventListener( "onEvent", this._listener.onEvent ), "Same 'removeEventListener' call should return false second time" );
    }
	
	@Test( "Test 'isEmpty' behavior with 'addEventListener'" )
    public function testIsEmptyWithAddEventListener() : Void
    {
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addEventListener( "eventType", this._listener.onEvent );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeEventListener( "eventType", this._listener.onEvent );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }
	
	@Test( "Test 'dispatchEvent' behavior" )
    public function testDispatchEvent() : Void
    {
		this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
        Assert.equals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }
	
	@Test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );

        this._dispatcher.removeAllListeners();
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatchEvent( event );
        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
    }
	
	@Test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
		Assert.methodCallThrows( UnsupportedOperationException, this._dispatcher, this._dispatcher.isRegistered, [ this._listener ], "isRegistered should throw UnsupportedOperationException" );
    }
	
	@Test( "Test 'hasEventListener' behavior" )
    public function testHasEventListener() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.isTrue( this._dispatcher.hasEventListener( "onEvent" ), "'hasEventListener' should return true" );
        Assert.isTrue( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return true" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onAnotherEvent" ), "'hasEventListener' should return false" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onAnotherEvent", ( new MockEventListener() ).onEvent ), "'hasEventListener' should return false" );
    }
	
	@Test( "Test seal activation on 'removeEventListener' during dispatching" )
    public function testSealActivationOnRemoveEventListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveEventListener( this._listener );
		this._dispatcher.addEventListener( "onEvent", mockEventListener.onEvent );
		this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return false" );
	}
	
	@Test( "Test seal activation on 'addEventListener' during dispatching" )
    public function testSealActivationOnAddEventListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnAddEventListener( this._listener );
		this._dispatcher.addEventListener( "onEvent", mockEventListener.onEvent );
		var mockListener : MockEventListener = new MockEventListener();
		this._dispatcher.addEventListener( "onEvent", mockListener.onEvent );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 0, this._listener.eventReceivedCount, "Event shouldn't be received" );
		Assert.isTrue( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return true" );
	}
	
	@Test( "Test seal activation on 'removeAllListeners' during dispatching" )
    public function testSealActivationOnRemoveAllListeners() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveAllListeners();
		this._dispatcher.addEventListener( "onEvent", mockEventListener.onEvent );
		this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return false" );
	}
}

private class MockEventListener implements IEventListener
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
	
	public function handleEvent(e:IEvent):Void 
	{
		
	}
}

private class MockEventListenerForTestingSealingOnRemoveEventListener extends MockEventListener
{
    public var listener : MockEventListener;

    public function new( listener : MockEventListener )
    {
		super();
		this.listener = listener;
    }

    override public function onEvent( e : BasicEvent ) : Void
    {
        super.onEvent( e );
		e.target.removeEventListener( "onEvent", listener.onEvent );
    }
}

private class MockEventListenerForTestingSealingOnAddEventListener extends MockEventListener
{
    public var listener : MockEventListener;

    public function new( listener : MockEventListener )
    {
		super();
		this.listener = listener;
    }

    override public function onEvent( e : BasicEvent ) : Void
    {
        super.onEvent( e );
		e.target.addEventListener( "onEvent", listener.onEvent );
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