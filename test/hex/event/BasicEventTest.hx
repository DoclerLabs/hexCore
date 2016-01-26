package hex.event;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class BasicEventTest
{
    @Test( "Test 'type' parameter passed to constructor" )
    public function testType() : Void
    {
        var type : String       = "type";
        var e = new BasicEvent( type, {} );

        Assert.equals( type, e.type, "'type' property should be the same passed to constructor" );
    }

    @Test( "Test 'target' parameter passed to constructor" )
    public function testTarget() : Void
    {
        var target = new MockTarget();
        var e = new BasicEvent( "", target );

        Assert.equals( target, e.target, "'target' property should be the same passed to constructor" );
    }

    @Test( "Test clone method" )
    public function testClone() : Void
    {
        var type : String               = "type";
        var target = new MockTarget();
        var e = new BasicEvent( type, target );
        var clonedEvent : BasicEvent    = e.clone();

        Assert.equals( type, clonedEvent.type, "'clone' method should return cloned event with same 'type' property" );
        Assert.equals( target, clonedEvent.target, "'clone' method should return cloned event with same 'target' property" );
    }
}

private class MockTarget
{
    public function new()
    {

    }
}