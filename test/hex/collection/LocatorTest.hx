package hex.collection;

import hex.error.Exception;
import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.error.NoSuchElementException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorTest
{
	var _locator : MockLocator;

	@Before
    public function setUp() : Void
    {
        this._locator = new MockLocator();
    }

    @After
    public function tearDown() : Void
    {
        this._locator.release();
        this._locator = null;
    }

    @Test( "Test 'release' behavior" )
    public function testRelease() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        this._locator.register( mockKey, mockValue );
        this._locator.release();
		
        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );
    }

    @Test( "Test 'clear' behavior" )
    public function testClear() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        this._locator.register( mockKey, mockValue );
        this._locator.clear();
		
        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );
        Assert.isFalse( this._locator.isRegisteredWithKey( mockKey ), "'isRegisteredWithKey' should return false" );
    }
	
	@Test( "Test 'isEmpty' behavior" )
    public function testIsEmpty() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );
        this._locator.register( mockKey, mockValue );
        Assert.isFalse( this._locator.isEmpty(), "'isEmpty' should return false" );
    }

    @Test( "Test 'getKeys' and 'getValues' behaviors" )
    public function testGetKeysAndGetValues() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        var keyList : Array<MockKeyClass> = [ mockKey, new MockKeyClass(), new MockKeyClass() ];
        var valueList : Array<MockValueClass> = [ mockValue, new MockValueClass(), new MockValueClass() ];

        var len : Int = keyList.length;
        for ( i in 0...len )
        {
            this._locator.register( keyList[ i ], valueList[ i ] );
        }

        var getKeysList : Array<MockKeyClass> = this._locator.keys();
        Assert.deepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map" );

        var getValuesList :Array<MockValueClass> = this._locator.values();
        Assert.deepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map" );

        this._locator.unregister( mockKey );
        keyList.splice( keyList.indexOf( mockKey ), 1 );
        valueList.splice( valueList.indexOf( mockValue ), 1 );

        getKeysList = this._locator.keys();
        Assert.deepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map after removal" );

        getValuesList = this._locator.values();
        Assert.deepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map after removal" );

        this._locator.clear();
        getKeysList = this._locator.keys();
        Assert.equals( 0, getKeysList.length, "'getKeys' should return an empty 'Array' after 'clear' call" );
        getValuesList = this._locator.values();
        Assert.equals( 0, getValuesList.length, "'getValues' should return an empty 'Array' after 'clear' call" );
    }

    @Test( "Test 'isRegisteredWithKey' behavior" )
    public function testIsRegisteredWithKey() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        Assert.isFalse( this._locator.isRegisteredWithKey( mockKey ), "'isRegisteredWithKey' should return false when the key was never added" );

        this._locator.register( mockKey, mockValue );
        Assert.isTrue( this._locator.isRegisteredWithKey( mockKey ), "'isRegisteredWithKey' should return true when the key was added" );

        this._locator.unregister( mockKey );
        Assert.isFalse( this._locator.isRegisteredWithKey( mockKey ), "'isRegisteredWithKey' should return false when the key was removed" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.isRegisteredWithKey, [ emptyKey ], "'isRegisteredWithKey' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.isRegisteredWithKey, [ null ], "'isRegisteredWithKey' should throw NullPointerException" );
    }

    @Test( "Test 'locate' behavior" )
    public function testLocate() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        Assert.methodCallThrows( NoSuchElementException, this._locator, this._locator.locate, [ mockKey ], "'locate' should throw NoSuchElementException when the value was never added" );

        this._locator.register( mockKey, mockValue );
        Assert.equals( mockValue, this._locator.locate( mockKey ), "'locate' should return mockValue when the value was added" );

        this._locator.unregister( mockKey );
        Assert.methodCallThrows( NoSuchElementException, this._locator, this._locator.locate, [ mockKey ], "'locate' should throw NoSuchElementException when the value was removed" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.locate, [ emptyKey ], "'locate' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.locate, [ null ], "'locate' should throw NullPointerException" );
    }

    @Test( "Test 'add' behavior" )
    public function testAdd() : Void
    {
        var locator = new Locator();
        var map : Map<Int, String> = [ 1 => "a" ];
        locator.add( map );

        Assert.equals( "a", locator.locate( 1 ), "'locate' should return added value" );
        Assert.methodCallThrows( IllegalArgumentException, locator, locator.add, [ map ], "'add' should throw IllegalArgumentException when key is already added" );
    }

    @Test( "Test 'register' behavior" )
    public function testRegister() : Void
    {
		MockLocator.dispatchRegisterEventCallcount = 0;
		MockLocator.lastRegisteredKeyDispatched = null;
		MockLocator.lastRegisteredValueDispatched = null;
		
		MockLocator.dispatchUnegisterEventCallcount = 0;
		MockLocator.lastUnregisteredKeyDispatched = null;
		
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

		Assert.isTrue( this._locator.register( mockKey, mockValue ), "'register' call should return true" );
		
		Assert.equals( 1, MockLocator.dispatchRegisterEventCallcount, "'register' event should be dispatched" );
		Assert.equals( 0, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should not be dispatched" );
		
		Assert.equals( mockKey, MockLocator.lastRegisteredKeyDispatched, "key should be passed as an argument during 'register' event dispatch" );
		Assert.equals( mockValue, MockLocator.lastRegisteredValueDispatched, "value should be passed as an argument during 'register' event dispatch" );
		
        Assert.equals( mockValue, this._locator.locate( mockKey ), "'locate' should return registered value" );
        Assert.methodCallThrows( IllegalArgumentException, this._locator, this._locator.register, [ mockKey, mockValue ], "'register' should throw IllegalArgumentException when key is already registered" );
		
		Assert.equals( 1, MockLocator.dispatchRegisterEventCallcount, "'register' event should not be dispatched this time" );
		Assert.equals( 0, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should not be dispatched" );
    }

    @Test( "Test 'unregister' behavior" )
    public function testUnregister() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        this._locator.register( mockKey, mockValue );
		
		MockLocator.dispatchRegisterEventCallcount = 0;
		MockLocator.lastRegisteredKeyDispatched = null;
		MockLocator.lastRegisteredValueDispatched = null;
		
		MockLocator.dispatchUnegisterEventCallcount = 0;
		MockLocator.lastUnregisteredKeyDispatched = null;
		
        var value : Bool = this._locator.unregister( mockKey );
		
        Assert.equals( true, value, "'unregister' should return true" );
        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );
		
		Assert.equals( 0, MockLocator.dispatchRegisterEventCallcount, "'register' event should not be dispatched" );
		Assert.equals( 1, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should be dispatched" );
		Assert.equals( mockKey, MockLocator.lastUnregisteredKeyDispatched, "key should be passed as an argument during 'unregister' event dispatch" );

        Assert.isFalse( this._locator.unregister( mockKey ), "'unregister' should return false when the key is not associtaed to nay value" );
		
		Assert.equals( 0, MockLocator.dispatchRegisterEventCallcount, "'register' event should not be dispatched" );
		Assert.equals( 1, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should not be dispatched anymore" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.unregister, [emptyKey], "'unregister' should throw NullPointerException" );
		
		Assert.equals( 0, MockLocator.dispatchRegisterEventCallcount, "'register' event should not be dispatched" );
		Assert.equals( 1, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should not be dispatched anymore" );
		
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.unregister, [null], "'unregister' should throw NullPointerException" );
		
		Assert.equals( 0, MockLocator.dispatchRegisterEventCallcount, "'register' event should not be dispatched" );
		Assert.equals( 1, MockLocator.dispatchUnegisterEventCallcount, "'unregister' event should not be dispatched anymore" );
    }
	
	@Test( "Test without inheritance" )
    public function testWithoutInheritance() : Void
    {
		var locator = new Locator<String, Bool>();
		var listener = new MockListener();
		locator.addListener( listener );
		
		listener.reset();
		locator.register( 'test', true );
		Assert.equals( 1, listener.callbackCallCount );
		Assert.equals( 'test', listener.callbackKey );
		Assert.equals( true, listener.callbackValue );
		
		listener.reset();
		locator.unregister( 'test' );
		Assert.equals( 1, listener.callbackCallCount );
		Assert.equals( 'test', listener.callbackKey );
		Assert.isNull( listener.callbackValue );
	}
}

private class MockListener implements ILocatorListener<String, Bool>
{
	public var callbackCallCount 	: Int = 0;
	public var callbackKey 			: String;
	public var callbackValue 		: Bool;
	
	public function new()
	{
		
	}
	
	public function reset() : Void
	{
		this.callbackCallCount 	= 0;
		this.callbackKey 		= null;
		this.callbackValue 		= null;
	}
	
	public function onRegister( key : String, value : Bool ) : Void
	{
		trace( key, value );
		
		this.callbackCallCount++;
		this.callbackKey 	= key;
		this.callbackValue 	= value;
	}
	
    public function onUnregister( key : String ) : Void
	{
		trace( key );
		this.callbackCallCount++;
		this.callbackKey 	= key;
	}
}

private class MockKeyClass
{
    public var name : String;
	
	public function new()
	{
		
	}
}

private class MockValueClass
{
    public var name : String;
	
	public function new()
	{
		
	}
}

private class MockLocator extends Locator<MockKeyClass, MockValueClass>
{
	static public var dispatchRegisterEventCallcount 	: UInt = 0;
	static public var dispatchUnegisterEventCallcount 	: UInt = 0;
	
	static public var lastRegisteredKeyDispatched		: MockKeyClass;
	static public var lastRegisteredValueDispatched		: MockValueClass;
	static public var lastUnregisteredKeyDispatched		: MockKeyClass;
	
	public function new()
	{
		super();
	}
	
	override function _dispatchRegisterEvent( key : MockKeyClass, value : MockValueClass ) : Void 
	{
		MockLocator.dispatchRegisterEventCallcount++;
		MockLocator.lastRegisteredKeyDispatched = key;
		MockLocator.lastRegisteredValueDispatched = value;
	}
	
	override function _dispatchUnregisterEvent( key : MockKeyClass ) : Void 
	{
		MockLocator.dispatchUnegisterEventCallcount++;
		MockLocator.lastUnregisteredKeyDispatched = key;
	}
}