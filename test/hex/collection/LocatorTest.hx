package hex.collection;

import hex.event.IEvent;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorTest
{
	private var _locator : Locator<MockKeyClass, MockValueClass>;

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
	
	@Test( "Test building a locator with String keys" )
    public function testRegisterKeyString() : Void
    {
        var locator : Locator<String, String> = new Locator();
		Assert.isTrue( locator.register( "hello", "world" ), "'register' call should return true" );
		Assert.isTrue( locator.register( "hola", "mundo" ), "'register' call should return true" );
        Assert.equals( "world", locator.locate( "hello" ), "'locate' should return registered value" );
    }
	
	@Test( "Test 'isEmpty' behavior" )
    public function testIsEmpty() : Void
    {
        var mockKey     : MockKeyClass 		= new MockKeyClass();
        var mockValue   : MockValueClass 	= new MockValueClass();

        Assert.isTrue( this._locator.isEmpty(), "'isEmpty' should return true" );
        this._locator.register( mockKey, mockValue );
        Assert.isFalse( this._locator.isEmpty(), "'isEmpty' should return false" );
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