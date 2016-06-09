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
        this._dispatcher    = null;
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
    }
	
	private function _onCallback( e : BasicEvent ) : Void
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