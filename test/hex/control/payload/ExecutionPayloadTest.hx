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
		Assert.isNull( this._executionPayload.getClassName(), "class name should be null when it's not setted through accessor" );
	}
	
	#if !php
	@Test( "Test constructor null exception" )
    public function testConstructorNullException() : Void
    {
        Assert.constructorCallThrows( NullPointerException, ExecutionPayload, [ null ], "constructor should throw NullPointerException" );
    }
	#end
	
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
	
	@Test( "Test constructor without type" )
    public function testConstructorWithoutType() : Void
    {
		this._executionPayload 	= new ExecutionPayload( "test" );
		
        Assert.equals( "test", this._executionPayload.getData(), "data should be the same" );
        Assert.equals( String, this._executionPayload.getType(), "type should be the same" );
    }
	
	@Test( "Test constructor without type with name" )
    public function testConstructorWithoutTypeWithName() : Void
    {
		this._executionPayload 	= new ExecutionPayload( this._data ).withName( "name" );
		
        Assert.equals( this._data, this._executionPayload.getData(), "data should be the same" );
        Assert.equals( MockData, this._executionPayload.getType(), "type should be the same" );
        Assert.equals( "name", this._executionPayload.getName(), "name should be the same" );
    }
	
	@Test( "Test setting class name" )
    public function testSettingClassName() : Void
    {
		var data = new MockDataWithGeneric<String>();
		this._executionPayload 	= new ExecutionPayload( data ).withClassName( "hex.control.payload.MockDataWithGeneric<String>" ).withName( "name" );
		
        Assert.equals( data, this._executionPayload.getData(), "data should be the same" );
        Assert.equals( MockDataWithGeneric, this._executionPayload.getType(), "type should be the same" );
        Assert.equals( "hex.control.payload.MockDataWithGeneric<String>", this._executionPayload.getClassName(), "class name should be the same" );
        Assert.equals( "name", this._executionPayload.getName(), "name should be the same" );
    }
}

private class MockData implements IMockData
{
	public function new()
	{
		
	}
}