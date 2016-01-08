package hex.event;

import hex.error.IllegalArgumentException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class DispatcherTest
{
	private var _dispatcher   : Dispatcher<IMockListener>;
    private var _listener     : MockEventListener;

    @setUp
    public function setUp() : Void
    {
        this._dispatcher    = new Dispatcher<IMockListener>();
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
		var messageType : MessageType = new MessageType( "onMessage" );
		
        Assert.isTrue( this._dispatcher.addListener( this._listener ), "'addListener' call should return true" );
        Assert.isFalse( this._dispatcher.addListener( this._listener ), "Same 'addListener' calls should return false second time" );

        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 1, "Message should be received once" );
        Assert.deepEquals( ["something", 7], this._listener.lastEventReceived, "Message content received should be the same that was dispatched" );
		
        this._dispatcher.dispatch( messageType, ["somethingElse", 13] );

        Assert.equals( this._listener.eventReceivedCount, 2, "Message should be received twice" );
        Assert.deepEquals( ["somethingElse", 13], this._listener.lastEventReceived, "Message content received should be the same that was dispatched" );
    
		this._dispatcher.removeListener( this._listener );
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );

        Assert.methodCallThrows( IllegalArgumentException, this._dispatcher, this._dispatcher.addListener, [ this._listener ], "'addListener' should throw IllegalArgumentException when 'addHandler' was used previously on the same target" );
	}

    @test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
		var messageType : MessageType = new MessageType();
		
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.removeListener( this._listener ), "'removeListener' call should return true" );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 0, "Message should not been received" );
        Assert.isNull( this._listener.lastEventReceived, "Message should null" );
        Assert.isFalse( this._dispatcher.removeListener( this._listener ), "Same 'removeListener' call should return false second time" );
    
		this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        this._dispatcher.removeListener( this._listener );
        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 0, "Message should not be received" );
        Assert.isNull( this._listener.lastEventReceived, "Message received should be null" );
	}

    @test( "Test 'addHandler' behavior" )
    public function testAddHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
		Assert.isTrue( this._dispatcher.addHandler( messageType, this, this._listener.onMessage ), "'addHandler' call should return true" );
        Assert.isFalse( this._dispatcher.addHandler( messageType, this, this._listener.onMessage ), "Same 'addHandler' calls should return false second time" );
        
		this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 1, "Message should be received once" );
        Assert.deepEquals( ["something", 7], this._listener.lastEventReceived, "Message content received should be the same that was dispatched" );

        this._dispatcher.dispatch( messageType, ["somethingElse", 13] );

        Assert.equals( this._listener.eventReceivedCount, 2, "Message should be received twice" );
        Assert.deepEquals( ["somethingElse", 13], this._listener.lastEventReceived, "Message content should be the same that was dispatched" );
	
		this._dispatcher.removeHandler( messageType, this._listener, this._listener.onMessage );
        this._dispatcher.addListener( this._listener );
        Assert.methodCallThrows( IllegalArgumentException, this._dispatcher, this._dispatcher.addHandler, [messageType, this._listener, this._listener.onMessage ], "'addHandler' should throw IllegalArgumentException when addListener was used previously" );
	}
	
	@test( "Test 'removeHandler' behavior" )
    public function testRemoveHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener, this._listener.onMessage ), "'removeHandler' call should return true" );

        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 0, "Message should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Message received should be null" );
        Assert.isFalse( this._dispatcher.removeHandler( messageType, this._listener, this._listener.onMessage ), "Same 'removeHandler' call should return false second time" );
    }
	
	@test( "Test 'isEmpty' behavior with 'addHandler'" )
    public function testIsEmptyWithAddHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeHandler( messageType, this._listener, this._listener.onMessage );
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
	
	@test( "Test 'dispatch' behavior" )
    public function testDispatch() : Void
    {
		var messageType : MessageType = new MessageType();
		
        var dispatcher : Dispatcher<IMockListener> = new Dispatcher<IMockListener>();
        var mockListener : MockListener = new MockListener();
        dispatcher.addListener( mockListener );

        var message : MessageType = new MessageType();
        dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( mockListener.eventReceivedCount, 1, "Message should be received once" );
        Assert.deepEquals(  ["something", 7], mockListener.lastEventReceived, "Message content should be the same that was dispatched" );

        var anotherMessageType : MessageType = new MessageType();
        dispatcher.dispatch( anotherMessageType, ["somethingElse", 13] );

        Assert.equals( mockListener.eventReceivedCount, 2, "Message should have been received twice" );
        Assert.deepEquals( ["somethingElse", 13], mockListener.lastEventReceived, "Message content received should be the same that was dispatched" );
	}
	
	@test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
		var messageType : MessageType = new MessageType();
		
        this._dispatcher.addListener( this._listener );
        this._dispatcher.removeAllListeners();
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatch( messageType, ["something", 7] );
        Assert.equals( this._listener.eventReceivedCount, 0, "Message should not have been received" );
        Assert.isNull( this._listener.lastEventReceived, "Message received should be null" );
    }
	
	@test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
		var messageType : MessageType = new MessageType();
		
        Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );

        this._dispatcher.removeAllListeners();
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
        Assert.isTrue( this._dispatcher.isRegistered( this._listener, messageType ), "'isRegistered' should return true" );
        Assert.isFalse( this._dispatcher.isRegistered( this._listener, new MessageType() ), "'isRegistered' should return false" );
        Assert.isFalse( this._dispatcher.isRegistered( new MockEventListener(), messageType ), "'isRegistered' should return false" );
    }
	
	@test( "Test 'hasHandler' behavior" )
    public function testHasHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
        Assert.isFalse( this._dispatcher.hasHandler( messageType ), "'hasHandler' should return false" );
        Assert.isFalse( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return false" );
        this._dispatcher.addListener( this._listener );
        Assert.isTrue( this._dispatcher.hasHandler( messageType ), "'hasHandler' should return true" );
        Assert.isTrue( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return true" );
		Assert.isTrue( this._dispatcher.hasHandler( new MessageType() ), "'hasHandler' should return true" );

        this._dispatcher.removeAllListeners();
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.hasHandler( messageType ), "'hasHandler' should return true" );
        Assert.isTrue( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return true" );
        Assert.isFalse( this._dispatcher.hasHandler( new MessageType() ), "'hasHandler' should return false" );
        Assert.isFalse( this._dispatcher.hasHandler( new MessageType(), ( new MockEventListener() ).onMessage ), "'hasHandler' should return false" );
    }
	
	@test( "Test seal activation on 'removeListener' during dispatching" )
    public function testSealActivationOnRemoveListener() : Void
	{
		var messageType : MessageType = new MessageType();
		
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveListener( this._dispatcher, this._listener );
		this._dispatcher.addListener( mockEventListener );
		this._dispatcher.addListener( this._listener );
		
		this._dispatcher.dispatch( messageType, ["something", 7] );
		Assert.equals( 1, this._listener.eventReceivedCount, "Event should be received once" );
		Assert.isTrue( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return true" );
	}
	
	@test( "Test seal activation on 'addListener' during dispatching" )
    public function testSealActivationOnAddListener() : Void
	{
		var messageType : MessageType = new MessageType();
		
		var mockEventListener = new MockEventListenerForTestingSealingOnAddListener( this._dispatcher, this._listener );
		this._dispatcher.addListener( mockEventListener );
		var mockListener : MockEventListener = new MockEventListener();
		this._dispatcher.addListener( mockListener );
		
		this._dispatcher.dispatch( messageType, ["something", 7] );
		Assert.equals( 0, this._listener.eventReceivedCount, "Message shouldn't be received" );
		Assert.isFalse( this._dispatcher.isRegistered( this._listener ), "'isRegistered' should return false" );
	}
	
	@test( "Test seal activation on 'removeHandler' during dispatching" )
    public function testSealActivationOnRemoveHandler() : Void
	{
		var messageType : MessageType = new MessageType();
		
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveEventListener( this._dispatcher, this._listener, messageType );
		this._dispatcher.addHandler( messageType, mockEventListener, mockEventListener.onMessage );
		this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
		Assert.isTrue( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return true" );
		
		this._dispatcher.dispatch( messageType, ["something", 7] );
		Assert.equals( 1, this._listener.eventReceivedCount, "Message should have beeen received once" );
		Assert.isFalse( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return false" );
	}
	
	@test( "Test seal activation on 'addHandler' during dispatching" )
    public function testSealActivationOnAddHandler() : Void
	{
		var messageType : MessageType = new MessageType();
		
		var mockEventListener = new MockEventListenerForTestingSealingOnAddEventListener( this._dispatcher, this._listener, messageType );
		this._dispatcher.addHandler( messageType, mockEventListener, mockEventListener.onMessage );
		var mockListener : MockEventListener = new MockEventListener();
		this._dispatcher.addHandler( messageType, mockListener, mockListener.onMessage );
		
		this._dispatcher.dispatch( messageType, ["something", 7] );
		Assert.equals( 0, this._listener.eventReceivedCount, "Message shouldn't have been received" );
		Assert.isTrue( this._dispatcher.hasHandler( messageType, this._listener ), "'hasHandler' should return true" );
	}
	
	@test( "Test seal activation on 'removeAllListeners' during dispatching" )
    public function testSealActivationOnRemoveAllListeners() : Void
	{
		var messageType : MessageType = new MessageType();
		
		var mockEventListener = new MockEventListenerForTestingSealingOnRemoveAllListeners( this._dispatcher, this._listener );
		this._dispatcher.addHandler( messageType, mockEventListener, mockEventListener.onMessage );
		this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
		
		this._dispatcher.dispatch( messageType, ["something", 7] );
		Assert.equals( 1, this._listener.eventReceivedCount, "Message should have been received once" );
		Assert.isFalse( this._dispatcher.hasHandler( messageType, this._listener.onMessage ), "'hasHandler' should return false" );
	}
	
	@test( "Test 'dispatch' behavior with 'handleMessage' callback" )
    public function testDispatchWithHandleMessageCallback() : Void
    {
		var messageType : MessageType = new MessageType();
		
        var dispatcher : Dispatcher<MockHandleMessageListener> = new Dispatcher<MockHandleMessageListener>();
        var mockListener : MockHandleMessageListener = new MockHandleMessageListener();
        dispatcher.addListener( mockListener );

        var message : MessageType = new MessageType( "messageTypeName" );
        dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( mockListener.eventReceivedCount, 1, "Message should be received once" );
        Assert.equals( messageType, mockListener.messageTypeReceived, "MessageType received should be the same" );
        Assert.deepEquals(  ["something", 7], mockListener.lastDataReceived, "Message content should be the same that was dispatched" );

        var anotherMessageType : MessageType = new MessageType( "anotherMessageTypeName" );
        dispatcher.dispatch( anotherMessageType, ["somethingElse", 13] );

        Assert.equals( mockListener.eventReceivedCount, 2, "Message should have been received twice" );
        Assert.deepEquals( ["somethingElse", 13], mockListener.lastDataReceived, "Message content received should be the same that was dispatched" );
	}
}

private class MockHandleMessageListener
{
    public var messageTypeReceived 	: MessageType;
    public var eventReceivedCount 	: Int = 0;
    public var lastDataReceived 	: Array<Dynamic> = null;

    public function new()
    {

    }

    public function handleMessage( messageType : MessageType, s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
		this.messageTypeReceived = messageType;
        this.lastDataReceived = [ s, i ];
    }
}

private class MockListener implements IMockListener
{
	public var messageTypeReceived 	: MessageType;
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : Array<Dynamic> = null;

    public function new()
    {

    }

    public function handleMessage( messageType : MessageType, s : String, i : Int ) : Void
    {
		this.messageTypeReceived = messageType;
        this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
    }
	
	public function onMessage( s : String, i : Int ) : Void 
	{
		
	}
}

private interface IMockListener
{
    function onMessage( s : String, i : Int ) : Void;
}

private class MockEventListener implements IMockListener
{
	public var messageTypeReceived 	: MessageType;
    public var eventReceivedCount 	: Int = 0;
    public var lastEventReceived 	: Array<Dynamic> = null;

    public function new()
    {

    }

    public function onMessage( s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
    }
	
	public function handleMessage( messageType : MessageType, s : String, i : Int ) : Void
    {
		this.messageTypeReceived = messageType;
        this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
    }
	
	public function emptyMethod() : Void
	{
		
	}
}

private class MockEventListenerForTestingSealingOnRemoveListener extends MockEventListener
{
    public var dispatcher : Dispatcher<IMockListener>;
    public var listener : IMockListener;

    public function new( dispatcher : Dispatcher<IMockListener>, listener : IMockListener )
    {
		super();
		this.dispatcher = dispatcher;
		this.listener = listener;
    }

    override public function onMessage( s : String, i : Int ) : Void
    {
        super.onMessage( s, i );
		this.dispatcher.removeListener( listener );
    }
}

private class MockEventListenerForTestingSealingOnAddListener extends MockEventListener
{
    public var dispatcher 	: Dispatcher<IMockListener>;
    public var listener 	: IMockListener;

    public function new( dispatcher : Dispatcher<IMockListener>, listener : IMockListener )
    {
		super();
		this.dispatcher = dispatcher;
		this.listener = listener;
    }

    override public function onMessage( s : String, i : Int ) : Void
    {
        super.onMessage( s, i );
		this.dispatcher.addListener( listener );
    }
}

private class MockEventListenerForTestingSealingOnRemoveEventListener extends MockEventListener
{
    public var dispatcher 	: Dispatcher<IMockListener>;
    public var listener 	: IMockListener;
    public var messageType 	: MessageType;

    public function new( dispatcher : Dispatcher<IMockListener>, listener : IMockListener, messageType : MessageType )
    {
		super();
		
		this.dispatcher 	= dispatcher;
		this.listener 		= listener;
		this.messageType 	= messageType;
    }

    override public function onMessage( s : String, i : Int ) : Void
    {
        super.onMessage( s, i );
		this.dispatcher.removeHandler( this.messageType, listener, listener.onMessage );
    }
}

private class MockEventListenerForTestingSealingOnAddEventListener extends MockEventListener
{
    public var dispatcher 	: Dispatcher<IMockListener>;
    public var listener 	: IMockListener;
    public var messageType 	: MessageType;

    public function new( dispatcher : Dispatcher<IMockListener>, listener : IMockListener, messageType : MessageType )
    {
		super();
		
		this.dispatcher 	= dispatcher;
		this.listener 		= listener;
		this.messageType 	= messageType;
    }

    override public function onMessage( s : String, i : Int ) : Void
    {
        super.onMessage( s, i );
		this.dispatcher.addHandler( this.messageType, listener, listener.onMessage );
    }
}

private class MockEventListenerForTestingSealingOnRemoveAllListeners extends MockEventListener
{
    public var dispatcher : Dispatcher<IMockListener>;
    public var listener : IMockListener;

    public function new( dispatcher : Dispatcher<IMockListener>, listener : IMockListener )
    {
		super();
		this.dispatcher = dispatcher;
		this.listener = listener;
    }

    override public function onMessage( s : String, i : Int ) : Void
    {
        super.onMessage( s, i );
		this.dispatcher.removeAllListeners();
    }
}