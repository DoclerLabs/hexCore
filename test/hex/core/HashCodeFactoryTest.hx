package hex.core;

import hex.error.PrivateConstructorException;
import hex.unittest.assertion.Assert;

class HashCodeFactoryTest
{
    @test( "Test constructor can't be called" )
    public function testConstructorNullException() : Void
    {
        Assert.assertConstructorCallThrows( PrivateConstructorException, HashCodeFactory, [], "" );
    }

    @test( "Test 'getNextKEY' and 'previewKey' behaviors" )
    public function testGetNextKey() : Void
    {
        var previewKey : Int = HashCodeFactory.previewNextKey();
        Assert.assertIsType( previewKey, Int, "'HashCodeFactory.previewNextKey' should return number" );

        var nextKey : Int = HashCodeFactory.getNextKEY();
        Assert.assertIsType( nextKey, Int, "'HashCodeFactory.getNextKEY' should return number" );
        Assert.assertEquals( previewKey, nextKey, "'HashCodeFactory.getNextKEY' call tearDown 'HashCodeFactory.previewNextKey' call should return the same value" );
    }

    @test( "Test 'getKEY' behavior" )
    public function testGetKey() : Void
    {
        var o : MockObject = new MockObject();
        var previewKey : Int = HashCodeFactory.previewNextKey();
        var key : Int = HashCodeFactory.getKey( o );
        Assert.assertIsType( key, Int, "'HashCodeFactory.getKEY' should return number" );
        Assert.assertEquals( previewKey, key, "'HashCodeFactory.getKEY' call tearDown 'HashCodeFactory.previewNextKey' call should return the same value" );

        var anotherKey : Int = HashCodeFactory.getKey( o );
        Assert.assertEquals( key, anotherKey, "Two 'HashCodeFactory.getKEY' calls on the same target should return the same value" );
    }
}

private class MockObject
{
    public function new()
    {

    }
}