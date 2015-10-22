package hex.collection;

import hex.error.NullPointerException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class HashMapTest
{
	private var _map : HashMap<MockKeyClass, MockValueClass>;

	@setUp
    public function setUp() : Void
    {
        this._map = new HashMap<MockKeyClass, MockValueClass>();
    }

    @tearDown
    public function tearDown() : Void
    {
        this._map.clear();
        this._map = null;
    }
	
	@test( "Test 'isEmpty' behavior" )
    public function testIsEmpty() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        Assert.assertTrue( this._map.isEmpty(), "'isEmpty' should return true" );
        this._map.put( mockKey, mockValue );
        Assert.failTrue( this._map.isEmpty(), "'isEmpty' should return false" );
    }
	
	@test( "Test 'clear' behavior" )
    public function testClear() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        this._map.put( mockKey, mockValue );
        this._map.clear();
		
        Assert.assertTrue( this._map.isEmpty(), "'isEmpty' should return true" );
        Assert.assertIsNull( this._map.get( mockKey ), "'get' should return null" );
    }
	
	@test( "Test 'put' and 'get' behaviors" )
    public function testPutAndGet() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        var value : MockValueClass = this._map.put( mockKey, mockValue );
        Assert.assertIsNull( value, "'put' should return null when key was never registered" );
        Assert.assertEquals( mockValue, this._map.get( mockKey ), "'get' should return value argument" );

        var anotherMockValue : MockValueClass = new MockValueClass();
        value = this._map.put( mockKey, anotherMockValue );
        Assert.assertEquals( mockValue, value, "'put' should return previous value registered with key argument" );
        Assert.assertEquals( anotherMockValue, this._map.get( mockKey ), "'get' should return new value argument" );
        Assert.failEquals( mockValue, this._map.get( mockKey ), "'get' should not return previous value argument" );

        var emptyKey : MockKeyClass = null;
        Assert.assertMethodCallThrows( NullPointerException, this._map.get, [emptyKey], "'get' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.get, [null], "'get' should throw NullPointerException" );

        Assert.assertMethodCallThrows( NullPointerException, this._map.put, [emptyKey, mockValue], "'put' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.put, [null, mockValue], "'put' should throw NullPointerException" );

        var emptyValue : MockValueClass = null;
        Assert.assertMethodCallThrows( NullPointerException, this._map.put, [mockKey, emptyValue], "'put' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.put, [mockKey, null], "'put' should throw NullPointerException" );
    }
	
	@test( "Test 'remove' behavior" )
    public function testRemove() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        this._map.put( mockKey, mockValue );
        var value : MockValueClass = this._map.remove( mockKey );
        Assert.assertEquals( mockValue, value, "'remove' should return previous value registered with key argument" );
        Assert.assertTrue( this._map.isEmpty(), "'isEmpty' should return true" );

        Assert.assertIsNull( this._map.remove( mockKey ), "'remove' should return null when the key is not associtaed to nay value" );

        var emptyKey : MockKeyClass = null;
        Assert.assertMethodCallThrows( NullPointerException, this._map.remove, [emptyKey], "'remove' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.remove, [null], "'remove' should throw NullPointerException" );
    }
	
	@test( "Test 'size' behavior" )
    public function testSize() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        Assert.assertEquals( 0, this._map.size(), "'size' should return 0 when the map is empty" );

        this._map.put( mockKey, mockValue );
        Assert.assertEquals( 1, this._map.size(), "'size' should return 1 when one element is added" );

        this._map.put( new MockKeyClass(), new MockValueClass() );
        Assert.assertEquals( 2, this._map.size(), "'size' should return 2 when another element is added" );

        this._map.put( mockKey, new MockValueClass() );
        Assert.assertEquals( 2, this._map.size(), "'size' should return 1 when a new element is added with a previous key" );

        this._map.remove( mockKey );
        Assert.assertEquals( 1, this._map.size(), "'size' should return 1 when an element is removed" );

        this._map.clear();
        Assert.assertEquals( 0, this._map.size(), "'size' should return 0 when the map is cleared" );
    }
	
	@test( "Test 'containsKey' behavior" )
    public function testContainsKey() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        Assert.failTrue( this._map.containsKey( mockKey ), "'containsKey' should return false when the key was never added" );

        this._map.put( mockKey, mockValue );
        Assert.assertTrue( this._map.containsKey( mockKey ), "'containsKey' should return true when the key was added" );

        this._map.remove( mockKey );
        Assert.failTrue( this._map.containsKey( mockKey ), "'containsKey' should return false when the key was removed" );

        var emptyKey : MockKeyClass = null;
        Assert.assertMethodCallThrows( NullPointerException, this._map.containsKey, [emptyKey], "'containsKey' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.containsKey, [null], "'containsKey' should throw NullPointerException" );
    }
	
	@test( "Test 'containsValue' behavior" )
    public function testContainsValue() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        Assert.failTrue( this._map.containsValue( mockValue ), "'containsValue' should return false when the value was never added" );

        this._map.put( mockKey, mockValue );
        Assert.assertTrue( this._map.containsValue( mockValue ), "'containsValue' should return true when the value was added" );

        this._map.remove( mockKey );
        Assert.failTrue( this._map.containsValue( mockValue ), "'containsValue' should return false when the value was removed" );

        var emptyValue : MockValueClass = null;
        Assert.assertMethodCallThrows( NullPointerException, this._map.containsValue, [emptyValue], "'containsValue' should throw NullPointerException" );
        Assert.assertMethodCallThrows( NullPointerException, this._map.containsValue, [null], "'containsValue' should throw NullPointerException" );
    }
	
	@test( "Test 'getKeys' and 'getValues' behaviors" )
    public function testGetKeysAndGetValues() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        var keyList : Array<MockKeyClass> = [ mockKey, new MockKeyClass(), new MockKeyClass() ];
        var valueList : Array<MockValueClass> = [ mockValue, new MockValueClass(), new MockValueClass() ];

        var len : Int = keyList.length;
        for ( i in 0...len )
        {
            this._map.put( keyList[ i ], valueList[ i ] );
        }

        var getKeysList : Array<MockKeyClass> = this._map.getKeys();
        Assert.assertDeepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map" );

        var getValuesList :Array<MockValueClass> = this._map.getValues();
        Assert.assertDeepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map" );

        this._map.remove( mockKey );
        keyList.splice( keyList.indexOf( mockKey ), 1 );
        valueList.splice( valueList.indexOf( mockValue ), 1 );

        getKeysList = this._map.getKeys();
        Assert.assertDeepEquals( keyList, getKeysList, "'getKeys' doesn't return all the values added to the map after removal" );

        getValuesList = this._map.getValues();
        Assert.assertDeepEquals( valueList, getValuesList, "'getValues' doesn't return all the values added to the map after removal" );

        this._map.clear();
        getKeysList = this._map.getKeys();
        Assert.assertEquals( 0, getKeysList.length, "'getKeys' should return an empty 'Array' after 'clear' call" );
        getValuesList = this._map.getValues();
        Assert.assertEquals( 0, getValuesList.length, "'getValues' should return an empty 'Array' after 'clear' call" );
    }
	
	@test( "Test with Class key" )
    public function testClassKey() : Void
    {
		var m : HashMap<Dynamic, String> = new HashMap <Dynamic, String > ();
		
		m.put( String, "String" );
		Assert.assertEquals( "String", m.get( String ), "'get' should return expected value with 'String' class key" );
		
		m.put( Bool, "Bool" );
		Assert.assertEquals( "Bool", m.get( Bool ), "'get' should return expected value with 'Bool' class key" );
		
		m.put( Int, "Int" );
		Assert.assertEquals( "Int", m.get( Int ), "'get' should return expected value with 'Int' class key" );
		
		m.put( Float, "Float" );
		Assert.assertEquals( "Float", m.get( Float ), "'get' should return expected value with 'Float' class key" );
		
		m.put( CustomClass, "CustomClass" );
		Assert.assertEquals( "CustomClass", m.get( CustomClass ), "'get' should return expected value with 'CustomClass' class key" );
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