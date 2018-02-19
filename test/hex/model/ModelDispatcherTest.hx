package hex.model;

import hex.model.ModelDispatcher;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ModelDispatcherTest
{
	var _dispatcher : MockDispatcher;
	
	@Before
	public function setUp() : Void
	{
		this._dispatcher = new MockDispatcher();
	}

	@After
	public function tearDown() : Void
	{
		this._dispatcher = null;
	}
	
	@Test( "test 'addListener' behavior" )
	public function testAddListener() : Void
	{
		var listener = new MockListener();
		Assert.isTrue( this._dispatcher.addListener( listener ), "'addListener' should return true" );
		Assert.isFalse( this._dispatcher.addListener( listener ), "'addListener' should return false second time" );
		
		this._dispatcher.onSetSomething( "a", 3 );
		Assert.equals( 1, listener.onSetSomethingCallCount, "This method should be called once" );
		Assert.deepEquals( [ "a", 3 ], listener.onSetSomethingArgs, "arguments should be the same" );
		Assert.equals( 0, listener.onSetNothingCallCount, "This method should not be called" );
		
		this._dispatcher.onSetNothing();
		Assert.equals( 1, listener.onSetSomethingCallCount, "This method should not be called anymore" );
		Assert.equals( 1, listener.onSetNothingCallCount, "This method should be called once" );
		
		this._dispatcher.onSetSomething( "b", 4 );
		Assert.equals( 2, listener.onSetSomethingCallCount, "This method should be called twice" );
		Assert.deepEquals( [ "b", 4 ], listener.onSetSomethingArgs, "arguments should be the same" );
		Assert.equals( 1, listener.onSetNothingCallCount, "This method should not be called anymore" );
	}
	
	@Test( "test 'removeListener' behavior" )
	public function testRemoveListener() : Void
	{
		var listener = new MockListener();
		this._dispatcher.addListener( listener );
		
		Assert.isTrue( this._dispatcher.removeListener( listener ), "'removeListener' should return true" );
		Assert.isFalse( this._dispatcher.removeListener( listener ), "'removeListener' should return false second time" );
		
		this._dispatcher.onSetSomething( "a", 3 );
		Assert.equals( 0, listener.onSetSomethingCallCount, "This method should not be called" );
		Assert.isNull( listener.onSetSomethingArgs, "arguments should be null" );
		Assert.equals( 0, listener.onSetNothingCallCount, "This method should not be called" );
		
		this._dispatcher.addListener( listener );
		
		this._dispatcher.onSetSomething( "a", 3 );
		Assert.equals( 1, listener.onSetSomethingCallCount, "This method should be called once" );
		Assert.deepEquals( [ "a", 3 ], listener.onSetSomethingArgs, "arguments should be the same" );
		Assert.equals( 0, listener.onSetNothingCallCount, "This method should not be called" );
	}
}

private interface IMockListener
{
	function onSetSomething( s : String, i : Int ) : Void;
	function onSetNothing() : Void;
}

private class MockListener implements IMockListener
{
	public var onSetSomethingCallCount 	: Int = 0;
	public var onSetNothingCallCount 	: Int = 0;
	public var onSetSomethingArgs 		: Array<Dynamic>;
	
	public function new()
	{
		
	}
	
	public function onSetSomething( s : String, i : Int ) : Void 
	{
		this.onSetSomethingCallCount++;
		this.onSetSomethingArgs = [ s, i ];
	}
	
	public function onSetNothing() : Void 
	{
		this.onSetNothingCallCount++;
	}
}

private class MockDispatcher extends ModelDispatcher<IMockListener> implements IMockListener
{
	public function new()
	{
		super();
	}
	
	public function onSetSomething( s : String, i : Int ) : Void 
	{
		
	}
	
	public function onSetNothing() : Void 
	{
		
	}
}