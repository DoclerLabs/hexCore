package hex.collection;

import hex.error.Exception;
import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.error.NoSuchElementException;
import hex.event.IEvent;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorTest
{
	var _locator : Locator<MockKeyClass, MockValueClass>;

	@Before
    public function setUp() : Void
    {
        this._locator = new Locator<MockKeyClass, MockValueClass>();
    }

    @After
    public function tearDown() : Void
    {
        this._locator.clear();
        this._locator = null;
    }

    @Test( "Test 'release' behavior" )
    public function testRelease() : Void
    {
        var locator = new Locator();
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        locator.register( mockKey, mockValue );
        locator.release();
		
        Assert.isTrue( locator.isEmpty(), "'isEmpty' should return true" );
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
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

		Assert.isTrue( this._locator.register( mockKey, mockValue ), "'register' call should return true" );
        Assert.equals( mockValue, this._locator.locate( mockKey ), "'locate' should return registered value" );
        Assert.methodCallThrows( IllegalArgumentException, this._locator, this._locator.register, [ mockKey, mockValue ], "'register' should throw IllegalArgumentException when key is already registered" );
    }

    @Test( "Test 'unregister' behavior" )
    public function testUnregister() : Void
    {
        var mockKey = new MockKeyClass();
        var mockValue = new MockValueClass();

        this._locator.register( mockKey, mockValue );
        var value : Bool = this._locator.unregister( mockKey );
        Assert.equals( true, value, "'unregister' should return true" );
        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );

        Assert.isFalse( this._locator.unregister( mockKey ), "'unregister' should return false when the key is not associtaed to nay value" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.unregister, [emptyKey], "'unregister' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._locator, this._locator.unregister, [null], "'unregister' should throw NullPointerException" );
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