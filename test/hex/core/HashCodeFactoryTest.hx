package hex.core;

import hex.error.PrivateConstructorException;
import hex.unittest.assertion.Assert;

class HashCodeFactoryTest
{
    @Test( "Test constructor can't be called" )
    public function testConstructorNullException() : Void
    {
        Assert.constructorCallThrows( PrivateConstructorException, HashCodeFactory, [], "" );
    }

    @Test( "Test 'getNextKEY' and 'previewKey' behaviors" )
    public function testGetNextKey() : Void
    {
        var previewKey : Int = HashCodeFactory.previewNextKey();
        Assert.isInstanceOf( previewKey, Int, "'HashCodeFactory.previewNextKey' should return number" );

        var nextKey : Int = HashCodeFactory.getNextKEY();
        Assert.isInstanceOf( nextKey, Int, "'HashCodeFactory.getNextKEY' should return number" );
        Assert.equals( previewKey, nextKey, "'HashCodeFactory.getNextKEY' call tearDown 'HashCodeFactory.previewNextKey' call should return the same value" );
    }

    @Test( "Test 'getKEY' behavior" )
    public function testGetKey() : Void
    {
        var o = new MockObject();
        var previewKey : Int = HashCodeFactory.previewNextKey();
        var key : Int = HashCodeFactory.getKey( o );
        Assert.isInstanceOf( key, Int, "'HashCodeFactory.getKEY' should return number" );
        Assert.equals( previewKey, key, "'HashCodeFactory.getKEY' call tearDown 'HashCodeFactory.previewNextKey' call should return the same value" );

        var anotherKey : Int = HashCodeFactory.getKey( o );
        Assert.equals( key, anotherKey, "Two 'HashCodeFactory.getKEY' calls on the same target should return the same value" );
    }
}

private class MockObject
{
    public function new()
    {

    }
}