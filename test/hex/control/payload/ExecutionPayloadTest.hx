package hex.control.payload;

import hex.control.payload.ExecutionPayload;
import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ExecutionPayloadTest
{

	var _data 				: MockData;
	var _executionPayload 	: ExecutionPayload;

    @Before
    public function setUp() : Void
    {
        this._data 				= new MockData();
        this._executionPayload 	= new ExecutionPayload( this._data, IMockData, "name" );
    }

    @After
    public function tearDown() : Void
    {
        this._data 				= null;
        this._executionPayload 	= null;
    }
	
	@Test( "Test constructor" )
    public function testConstructor() : Void
    {
        Assert.equals( this._data, this._executionPayload.getData(), "data should be the same" );
        Assert.equals( IMockData, this._executionPayload.getType(), "type should be the same" );
        Assert.equals( "name", this._executionPayload.getName(), "name should be the same" );
    }
	
	#if !php
	@Test( "Test constructor null exception" )
    public function testConstructorNullException() : Void
    {
        Assert.constructorCallThrows( NullPointerException, ExecutionPayload, [ null ], "constructor should throw NullPointerException" );
    }
	#end
	
	@Test( "Test constructor throws IllegalArgumentException" )
    public function testConstructorThrowsIllegalArgumentException() : Void
    {
        Assert.constructorCallThrows( IllegalArgumentException, ExecutionPayload, [ this._data, String ], "constructor should throw IllegalArgumentException" );
    }
	
	@Test( "Test overwriting type property" )
    public function testOverwritingType() : Void
    {
		this._executionPayload.withClass( IMockType );
        Assert.notEquals( IMockData, this._executionPayload.getType(), "type should not be the same" );
        Assert.equals( IMockType, this._executionPayload.getType(), "type should be the same" );
    }
	
	@Test( "Test overwriting name property" )
    public function testOverwritingName() : Void
    {
		this._executionPayload.withName( "anotherName" );
        Assert.notEquals( "name", this._executionPayload.getName(), "name should not be the same" );
        Assert.equals( "anotherName", this._executionPayload.getName(), "name should be the same" );
    }
	
	@Test( "Test passing no name parameter to constructor" )
    public function testNoNameParameterToConstructor() : Void
    {
		var executionPayload = new ExecutionPayload( this._data, IMockData );
        Assert.equals( "", executionPayload.getName(), "name should be empty String" );
    }
}

private class MockData implements IMockData
{
	public function new()
	{
		
	}
}

private interface IMockData
{
	
}

private interface IMockType
{
	
}