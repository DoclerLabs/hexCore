package hex.event;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ClosuredispatcherTest
{
    var _dispatcher   		: ClosureDispatcher;
    var _listener     		: MockEventListener;

    @Before
    public function setUp() : Void
    {
        this._dispatcher    	= new ClosureDispatcher();
        this._listener      	= new MockEventListener();
    }

    @After
    public function tearDown() : Void
    {
        this._dispatcher    	= null;
        this._listener      	= null;
    }
	
	@Test( "Test 'addHandler' behavior" )
    public function testAddHandler() : Void
    {
		var messageType = new MessageType();
		
		Assert.isTrue( this._dispatcher.addHandler( messageType, this._listener.onMessage ), "'addHandler' call should return true" );
        Assert.isFalse( this._dispatcher.addHandler( messageType, this._listener.onMessage ), "Same 'addHandler' calls should return false second time" );
		Assert.isTrue( this._dispatcher.addHandler( messageType, this._listener.onSameMessage ), "'addHandler' call should return true" );
        
		this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 2, "Message should be received twice" );
        Assert.deepEquals( ["something", 7], this._listener.lastDataReceived, "Message content received should be the same that was dispatched" );
		
		Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener.onSameMessage ), "'removeHandler' call should return true" );

        this._dispatcher.dispatch( messageType, ["somethingElse", 13] );

        Assert.equals( this._listener.eventReceivedCount, 3, "Message should be received twice" );
        Assert.deepEquals( ["somethingElse", 13], this._listener.lastDataReceived, "Message content should be the same that was dispatched" );
	
		Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener.onMessage ), "'removeHandler' call should return true" );
    }
	
	@Test( "Test 'removeHandler' behavior" )
    public function testRemoveHandler() : Void
    {
		var messageType = new MessageType();
		
        this._dispatcher.addHandler( messageType, this._listener.onMessage );
        this._dispatcher.addHandler( messageType, this._listener.onSameMessage );
        Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener.onMessage ), "'removeHandler' call should return true" );
        Assert.isFalse( this._dispatcher.removeHandler( messageType, this._listener.onMessage ), "'removeHandler' call should return false second time" );
        Assert.isTrue( this._dispatcher.removeHandler( messageType, this._listener.onSameMessage ), "'removeHandler' call should return true" );
        Assert.isFalse( this._dispatcher.removeHandler( messageType, this._listener.onSameMessage ), "'removeHandler' call should return false second time" );

        this._dispatcher.dispatch( messageType, ["something", 7] );

        Assert.equals( this._listener.eventReceivedCount, 0, "Message should be received once" );
        Assert.isNull( this._listener.lastDataReceived, "Message received should be null" );
    }
	
	@Test( "Test 'isEmpty' behavior with 'addHandler'" )
    public function testIsEmptyWithAddHandler() : Void
    {
		var messageType = new MessageType();
		
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addHandler( messageType, this._listener.onMessage );
        Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeHandler( messageType, this._listener.onMessage );
        Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
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
    public var lastDataReceived 	: Array<Dynamic> = null;

    public function new()
    {
		
    }

    public function onMessage( s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
        this.lastDataReceived = [ s, i ];
    }
	
	public function onSameMessage( s : String, i : Int ) : Void
    {
        this.eventReceivedCount++;
        this.lastDataReceived = [ s, i ];
    }
	
	public function handleMessage( messageType : MessageType, s : String, i : Int ) : Void
    {
		this.messageTypeReceived = messageType;
        this.eventReceivedCount++;
        this.lastDataReceived = [ s, i ];
    }
	
	public function emptyMethod() : Void
	{
		
	}
}