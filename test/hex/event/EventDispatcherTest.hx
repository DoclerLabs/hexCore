package hex.event;

import hex.error.UnsupportedOperationException;
import hex.error.IllegalArgumentException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class EventDispatcherTest
{
    private var _dispatcher   : EventDispatcher<IMockEventListener, BasicEvent>;
    private var _listener     : MockEventListener;

    @setUp
    public function setUp() : Void
    {
        this._dispatcher    = new EventDispatcher<IMockEventListener, BasicEvent>();
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
        Assert.isTrue( this._dispatcher.addListener( this._listener ), "'addListener' call should return true" );
        Assert.isFalse( this._dispatcher.addListener( this._listener ), "Same 'addListener' calls should return false second time" );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 1, "Event should be received once" );
        Assert.equals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }

    @test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.removeListener( this._listener ), "'removeListener' call should return true" );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
        Assert.isFalse( this._dispatcher.removeListener( this._listener ), "Same 'removeListener' call should return false second time" );
    }

    @test( "Test 'addEventListener' behavior" )
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

    @test( "Test 'removeEventListener' behavior" )
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

    @test( "Test 'isEmpty' behavior with 'addEventListener'" )
    public function testIsEmptyWithAddEventListener() : Void
    {
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addEventListener( "eventType", this._listener.onEvent );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeEventListener( "eventType", this._listener.onEvent );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }

    @test( "Test 'isEmpty' behavior with 'addListener'" )
    public function testIsEmptyWithAddListener() : Void
    {
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addListener( this._listener );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeListener( this._listener );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }

    @test( "Test 'dispatchEvent' behavior" )
    public function testDispatchEvent() : Void
    {
        var dispatcher : EventDispatcher<IEventListener, BasicEvent> = new EventDispatcher<IEventListener, BasicEvent>();
        var mockListener : MockListener = new MockListener();
        dispatcher.addListener( mockListener );

        var event : BasicEvent = new BasicEvent( "onEvent", dispatcher );
        dispatcher.dispatchEvent( event );

        Assert.equals( mockListener.eventReceivedCount, 1, "Event should be received once" );
        Assert.equals( mockListener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        dispatcher.dispatchEvent( anotherEvent );

        Assert.equals( mockListener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.equals( mockListener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
	}

    @test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
        this._dispatcher.addListener( this._listener );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );

        this._dispatcher.removeAllListeners();
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatchEvent( event );
        Assert.equals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
    }

    @test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
        Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );

        this._dispatcher.removeAllListeners();
		Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
    }

    @test( "Test 'hasEventListener' behavior" )
    public function testHasEventListener() : Void
    {
        Assert.isFalse( this._dispatcher.hasEventListener( "onEvent" ), "'hasEventListener' should return false" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.isFalse( this._dispatcher.hasEventListener( "onEvent" ), "'hasEventListener' should return false" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return false" );
		Assert.isFalse( this._dispatcher.hasEventListener( "onAnotherEvent" ), "'hasEventListener' should return false" );

        this._dispatcher.removeAllListeners();
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.isTrue( this._dispatcher.hasEventListener( "onEvent" ), "'hasEventListener' should return true" );
        Assert.isTrue( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return true" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onAnotherEvent" ), "'hasEventListener' should return false" );
        Assert.isFalse( this._dispatcher.hasEventListener( "onAnotherEvent", ( new MockEventListener() ).onEvent ), "'hasEventListener' should return false" );
    }
	
	@test( "Test seal activation on 'removeListener' during dispatching" )
    public function testSealActivationOnRemoveListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveListener( this._listener );
		this._dispatcher.addListener( mockEventListener );
		this._dispatcher.addListener( this._listener );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
	}
	
	@test( "Test seal activation on 'addListener' during dispatching" )
    public function testSealActivationOnAddListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnAddListener( this._listener );
		this._dispatcher.addListener( mockEventListener );
		var mockListener : MockEventListener = new MockEventListener();
		this._dispatcher.addListener( mockListener );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 0, this._listener.eventReceivedCount, "Event shouldn't be received" );
		Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
	}
	
	@test( "Test seal activation on 'removeEventListener' during dispatching" )
    public function testSealActivationOnRemoveEventListener() : Void
	{
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveEventListener( this._listener );
		this._dispatcher.addEventListener( "onEvent", mockEventListener.onEvent );
		this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
		
		this._dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isFalse( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return false" );
	}
	
	@test( "Test seal activation on 'addEventListener' during dispatching" )
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
	
	@test( "Test seal activation on 'removeAllListeners' during dispatching" )
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

private class MockEventListenerForTestingSealingOnRemoveEventListener extends MockEventListener
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
		e.target.removeEventListener( "onEvent", listener.onEvent );
    }
}

private class MockEventListenerForTestingSealingOnAddEventListener extends MockEventListener
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
