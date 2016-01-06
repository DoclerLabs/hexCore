package hex.event;

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
	}
	
	@test( "Test 'removeHandler' behavior" )
    public function testRemoveHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener.onMessage ), "'removeHandler' call should return true" );

        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 0, "Message should be received once" );
        Assert.isNull( this._listener.lastEventReceived, "Message received should be null" );
        Assert.isFalse( this._dispatcher.removeHandler( messageType, this._listener.onMessage ), "Same 'removeHandler' call should return false second time" );
    }
	
	@test( "Test 'isEmpty' behavior with 'addHandler'" )
    public function testIsEmptyWithAddHandler() : Void
    {
		var messageType : MessageType = new MessageType();
		
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addHandler( messageType, this._listener, this._listener.onMessage );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeHandler( messageType, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }
	
	/*@test( "Test 'isEmpty' behavior with 'addListener'" )
    public function testIsEmptyWithAddListener() : Void
    {
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addListener( this._listener );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeListener( this._listener );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }*/
	
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

        Assert.equals( mockListener.eventReceivedCount, 2, "Message should be received twice" );
        Assert.deepEquals( ["somethingElse", 13], mockListener.lastEventReceived, "Message content received should be the same that was dispatched" );
	}
}

private class MockListener implements IMockListener
{
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : Array<Dynamic> = null;

    public function new()
    {

    }

    public function handleMessage( s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
    }
	
	public function onMessage( s : String, i : Int ) : Void 
	{
		this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
	}
}

private interface IMockListener
{
    function onMessage( s : String, i : Int ) : Void;
}

private class MockEventListener implements IMockListener
{
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : Array<Dynamic> = null;

    public function new()
    {

    }

    public function onMessage( s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
    }
	
	public function handleMessage( s : String, i : Int ) : Void
    {
		this.eventReceivedCount++;
        this.lastEventReceived = [ s, i ];
	}
}