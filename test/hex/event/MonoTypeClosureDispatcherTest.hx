package hex.event;

import hex.error.IllegalArgumentException;
import hex.event.BasicEvent;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author duke
 */
class MonoTypeClosureDispatcherTest
{
	var _lastReceivedEvent 	: BasicEvent;
	var _target				: MockTarget;
	var _dispatcher			: MonoTypeClosureDispatcher<BasicEvent>;

	public function new() 
	{
		
	}
	
	@Before
    public function setUp() : Void
    {
        this._lastReceivedEvent = null;
		this._target = new MockTarget();
        this._dispatcher = new MonoTypeClosureDispatcher<BasicEvent>( "event", this._target );
		this._dispatcher.addEventListener( this._onCallback );
    }

    @After
    public function tearDown() : Void
    {
        this._dispatcher = null;
    }
	
	@Test( "Test dispatch method with illegal event type" )
    public function testDispatchMethodWithIllegalEventType() : Void
    {
		var event = new BasicEvent( "anotherEvent", this._target );
		Assert.methodCallThrows( IllegalArgumentException, this._dispatcher, this._dispatcher.dispatchEvent, [ event ], "'dispatchEvent' without illegal event type should trigger 'IllegalArgumentException'" );
    }
	
    @Test( "Test dispatch method with arguments" )
    public function testDispatchMethodWithArguments() : Void
    {
		var event = new BasicEvent( "event", this._target );
		this._dispatcher.dispatchEvent( event );
		
		Assert.equals( event, this._lastReceivedEvent, "events should be the same" );
		Assert.equals( this._target, this._lastReceivedEvent.target, "targets should be the same" );
		Assert.equals( "event", this._lastReceivedEvent.type, "types should be the same" );
		Assert.isInstanceOf( this._lastReceivedEvent, BasicEvent, "event received should be an instance of 'BasicEvent'" );
		
		this._lastReceivedEvent = null;
		this._dispatcher.removeEventListener( this._onCallback );
		this._dispatcher.dispatchEvent( event );
		Assert.isNull( this._lastReceivedEvent, "event should not be dispatched" );
    }
	
	@Test( "Test dispatch method without arguments" )
    public function testDispatchMethodWithoutArguments() : Void
    {
		#if ( haxe_ver >= "3.3" )
		this._dispatcher.dispatchEvent();
		
		Assert.equals( this._target, this._lastReceivedEvent.target, "targets should be the same" );
		Assert.equals( "event", this._lastReceivedEvent.type, "types should be the same" );
		Assert.isInstanceOf( this._lastReceivedEvent, BasicEvent, "event received should be an instance of 'BasicEvent'" );
		#else
		
		Assert.methodCallThrows( IllegalArgumentException, this._dispatcher, this._dispatcher.dispatchEvent, [], "'dispatchEvent' without argument should trigger 'IllegalArgumentException'" );
		
		#end
		
		this._lastReceivedEvent = null;
		this._dispatcher.removeEventListener( this._onCallback );
		var event = new BasicEvent( "event", this._target );
		this._dispatcher.dispatchEvent( event );
		
		Assert.isNull( this._lastReceivedEvent, "event should not be dispatched" );
    }
	
	@Test( "Test isEmpty" )
	public function testIsEmpty() : Void
	{
		Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
		this._dispatcher.removeEventListener( this._onAnotherCallback );
		Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
		this._dispatcher.removeEventListener( this._onCallback );
		Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
	}
	
	@Test( "Test removeAllListeners" )
	public function testRemoveAllListeners() : Void
	{
		this._dispatcher.addEventListener( this._onAnotherCallback );
		
		Assert.isFalse( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
		
		var event = new BasicEvent( "event", this._target );
		this._dispatcher.dispatchEvent( event );
		
		Assert.isNotNull( this._lastReceivedEvent, "event should not be dispatched" );
		
		this._lastReceivedEvent = null;
		this._dispatcher.removeAllListeners();
		this._dispatcher.dispatchEvent( event );
		
		Assert.isTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
		Assert.isNull( this._lastReceivedEvent, "event should not be dispatched" );
	}
	
	private function _onCallback( e : BasicEvent ) : Void
	{
		this._lastReceivedEvent = e;
	}
	
	private function _onAnotherCallback( e : BasicEvent ) : Void
	{
		this._lastReceivedEvent = e;
	}
}

private class MockTarget
{
    public function new()
    {

    }
}