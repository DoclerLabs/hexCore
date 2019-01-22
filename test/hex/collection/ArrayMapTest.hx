package hex.collection;

import hex.unittest.assertion.Assert;

using hex.error.Error;

/**
 * ...
 * @author Francis Bourre
 */
class ArrayMapTest
{
	var _map : ArrayMap<MockKeyClass, MockValueClass>;

	@Before
    public function setUp() : Void
    {
        this._map = new ArrayMap<MockKeyClass, MockValueClass>();
    }

    @After
    public function tearDown() : Void
    {
        this._map.clear();
        this._map = null;
    }
	
	@Test( "Test 'isEmpty' behavior" )
    public function testIsEmpty() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        Assert.isTrue( this._map.isEmpty(), "'isEmpty' should return true" );
        this._map.put( mockKey, mockValue );
        Assert.isFalse( this._map.isEmpty(), "'isEmpty' should return false" );
    }
	
	@Test( "Test 'clear' behavior" )
    public function testClear() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        this._map.put( mockKey, mockValue );
        this._map.clear();
		
        Assert.isTrue( this._map.isEmpty(), "'isEmpty' should return true" );
        Assert.isNull( this._map.get( mockKey ), "'get' should return null" );
    }
	
	@Test( "Test 'put' and 'get' behaviors" )
    public function testPutAndGet() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        var value : MockValueClass = this._map.put( mockKey, mockValue );
        Assert.isNull( value, "'put' should return null when key was never registered" );
        Assert.equals( mockValue, this._map.get( mockKey ), "'get' should return value argument" );

        var anotherMockValue = new MockValueClass();
        value = this._map.put( mockKey, anotherMockValue );
        Assert.equals( mockValue, value, "'put' should return previous value registered with key argument" );
        Assert.equals( anotherMockValue, this._map.get( mockKey ), "'get' should return new value argument" );
        Assert.notEquals( mockValue, this._map.get( mockKey ), "'get' should not return previous value argument" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._map, this._map.get, [emptyKey], "'get' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.get, [null], "'get' should throw NullPointerException" );

        Assert.methodCallThrows( NullPointerException, this._map, this._map.put, [emptyKey, mockValue], "'put' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.put, [null, mockValue], "'put' should throw NullPointerException" );

        var emptyValue : MockValueClass = null;
        Assert.methodCallThrows( NullPointerException, this._map, this._map.put, [mockKey, emptyValue], "'put' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.put, [mockKey, null], "'put' should throw NullPointerException" );
    }
	
	@Test( "Test 'remove' behavior" )
    public function testRemove() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        this._map.put( mockKey, mockValue );
        var value : MockValueClass = this._map.remove( mockKey );
        Assert.equals( mockValue, value, "'remove' should return previous value registered with key argument" );
        Assert.isTrue( this._map.isEmpty(), "'isEmpty' should return true" );

        Assert.isNull( this._map.remove( mockKey ), "'remove' should return null when the key is not associtaed to nay value" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._map, this._map.remove, [emptyKey], "'remove' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.remove, [null], "'remove' should throw NullPointerException" );
    }
	
	@Test( "Test 'size' behavior" )
    public function testSize() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        Assert.equals( 0, this._map.size(), "'size' should return 0 when the map is empty" );

        this._map.put( mockKey, mockValue );
        Assert.equals( 1, this._map.size(), "'size' should return 1 when one element is added" );

        this._map.put( new MockKeyClass(), new MockValueClass() );
        Assert.equals( 2, this._map.size(), "'size' should return 2 when another element is added" );

        this._map.put( mockKey, new MockValueClass() );
        Assert.equals( 2, this._map.size(), "'size' should return 1 when a new element is added with a previous key" );

        this._map.remove( mockKey );
        Assert.equals( 1, this._map.size(), "'size' should return 1 when an element is removed" );

        this._map.clear();
        Assert.equals( 0, this._map.size(), "'size' should return 0 when the map is cleared" );
    }
	
	@Test( "Test 'containsKey' behavior" )
    public function testContainsKey() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        Assert.isFalse( this._map.containsKey( mockKey ), "'containsKey' should return false when the key was never added" );

        this._map.put( mockKey, mockValue );
        Assert.isTrue( this._map.containsKey( mockKey ), "'containsKey' should return true when the key was added" );

        this._map.remove( mockKey );
        Assert.isFalse( this._map.containsKey( mockKey ), "'containsKey' should return false when the key was removed" );

        var emptyKey : MockKeyClass = null;
        Assert.methodCallThrows( NullPointerException, this._map, this._map.containsKey, [emptyKey], "'containsKey' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.containsKey, [null], "'containsKey' should throw NullPointerException" );
    }
	
	@Test( "Test 'containsValue' behavior" )
    public function testContainsValue() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        Assert.isFalse( this._map.containsValue( mockValue ), "'containsValue' should return false when the value was never added" );

        this._map.put( mockKey, mockValue );
        Assert.isTrue( this._map.containsValue( mockValue ), "'containsValue' should return true when the value was added" );

        this._map.remove( mockKey );
        Assert.isFalse( this._map.containsValue( mockValue ), "'containsValue' should return false when the value was removed" );

        var emptyValue : MockValueClass = null;
        Assert.methodCallThrows( NullPointerException, this._map, this._map.containsValue, [emptyValue], "'containsValue' should throw NullPointerException" );
        Assert.methodCallThrows( NullPointerException, this._map, this._map.containsValue, [null], "'containsValue' should throw NullPointerException" );
    }
	
	@Test( "Test 'getKeys' and 'getValues' behaviors" )
    public function testGetKeysAndGetValues() : Void
    {
        var mockKey     = new MockKeyClass();
        var mockValue   = new MockValueClass();

        var keyList : Array<MockKeyClass> = [ mockKey, new MockKeyClass(), new MockKeyClass() ];
        var valueList : Array<MockValueClass> = [ mockValue, new MockValueClass(), new MockValueClass() ];

        var len : Int = keyList.length;
        for ( i in 0...len )
        {
            this._map.put( keyList[ i ], valueList[ i ] );
        }

        var getKeysList : Array<MockKeyClass> = this._map.getKeys();
        Assert.deepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map" );

        var getValuesList :Array<MockValueClass> = this._map.getValues();
        Assert.deepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map" );

        this._map.remove( mockKey );
        keyList.splice( keyList.indexOf( mockKey ), 1 );
        valueList.splice( valueList.indexOf( mockValue ), 1 );

        getKeysList = this._map.getKeys();
        Assert.deepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map after removal" );

        getValuesList = this._map.getValues();
        Assert.deepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map after removal" );

        this._map.clear();
        getKeysList = this._map.getKeys();
        Assert.equals( 0, getKeysList.length, "'getKeys' should return an empty 'Array' after 'clear' call" );
        getValuesList = this._map.getValues();
        Assert.equals( 0, getValuesList.length, "'getValues' should return an empty 'Array' after 'clear' call" );
    }
	
	@Test( "Test with Class key" )
    public function testClassKey() : Void
    {
		var m = new ArrayMap <Dynamic, String > ();
		
		m.put( String, "String" );
		Assert.equals( "String", m.get( String ), "'get' should return expected value with 'String' class key" );
		
		m.put( Bool, "Bool" );
		Assert.equals( "Bool", m.get( Bool ), "'get' should return expected value with 'Bool' class key" );
		
		m.put( Int, "Int" );
		Assert.equals( "Int", m.get( Int ), "'get' should return expected value with 'Int' class key" );
		
		m.put( Float, "Float" );
		Assert.equals( "Float", m.get( Float ), "'get' should return expected value with 'Float' class key" );
		
		m.put( CustomClass, "CustomClass" );
		Assert.equals( "CustomClass", m.get( CustomClass ), "'get' should return expected value with 'CustomClass' class key" );
	}
	
	@Test( "Test clone" )
    public function testClone() : Void
    {
		var mockKey     		= new MockKeyClass();
		var anotherMockKey     	= new MockKeyClass();
        var mockValue   		= new MockValueClass();
		var anotherMockValue 	= new MockValueClass();
		
        var value 				= this._map.put( mockKey, mockValue );
        var anotherValue 		= this._map.put( anotherMockKey, anotherMockValue );
		
		var map = this._map.clone();
		
        Assert.equals( this._map.size(), map.size(), "maps size should be the same" );
        Assert.isNull( value, "'put' should return null when key was never registered" );
        Assert.equals( mockValue, map.get( mockKey ), "'get' should return value argument" );
        Assert.equals( anotherMockValue, map.get( anotherMockKey ), "'get' should return new value argument" );
        Assert.notEquals( map, this._map, "maps should contain same pairs but not equal" );

		var newKey 				= new MockKeyClass();
		var newMockValue   		= new MockValueClass();
		var newValue 			= map.put( newKey, newMockValue );
		Assert.isTrue( map.containsKey( newKey ) );
		Assert.isFalse( this._map.containsKey( newKey ) );
		
		this._map.clear();
		Assert.notEquals( this._map.size(), map.size(), "maps size should not be the same" );
	}
}

private class CustomClass
{

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