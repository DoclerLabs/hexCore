package hex.event;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class BasicEventTest
{
    @test( "Test 'type' parameter passed to constructor" )
    public function testType() : Void
    {
        var type : String       = "type";
        var e : BasicEvent      = new BasicEvent( type, {} );

        Assert.equals( type, e.type, "'type' property should be the same passed to constructor" );
    }

    @test( "Test 'target' parameter passed to constructor" )
    public function testTarget() : Void
    {
        var target : MockTarget = new MockTarget();
        var e : BasicEvent      = new BasicEvent( "", target );

        Assert.equals( target, e.target, "'target' property should be the same passed to constructor" );
    }

    @test( "Test clone method" )
    public function testClone() : Void
    {
        var type : String               = "type";
        var target : MockTarget         = new MockTarget();
        var e : BasicEvent              = new BasicEvent( type, target );
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