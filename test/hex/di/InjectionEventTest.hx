package hex.di;

import hex.MockDependencyInjector;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class InjectionEventTest
{
    @Test( "Test 'type' parameter passed to constructor" )
    public function testType() : Void
    {
        var type : String       = "type";
        var e = new InjectionEvent( type, new MockTarget(), this, InjectionEventTest );

        Assert.equals( type, e.type, "'type' property should be the same passed to constructor" );
    }

    @Test( "Test 'target' parameter passed to constructor" )
    public function testTarget() : Void
    {
        var target = new MockTarget();
        var e = new InjectionEvent( "", target, this, InjectionEventTest );

        Assert.equals( target, e.target, "'target' property should be the same passed to constructor" );
    }

    @Test( "Test clone method" )
    public function testClone() : Void
    {
        var type : String               	= "type";
        var target = new MockTarget();
        var e = new InjectionEvent( type, target, this, InjectionEventTest );
        var clonedEvent : InjectionEvent    = cast e.clone();

        Assert.equals( type, clonedEvent.type, "'clone' method should return cloned event with same 'type' property" );
        Assert.equals( target, clonedEvent.target, "'clone' method should return cloned event with same 'target' property" );
    }
	
	@Test( "Test parameters passed to constructor" )
    public function testParameters() : Void
    {
        var target = new MockTarget();
        var e = new InjectionEvent( "", target, this, InjectionEventTest );

        Assert.equals( this, e.instance, "'instance' property should be the same passed to constructor" );
        Assert.equals( InjectionEventTest, e.instanceType, "'instanceType' property should be the same passed to constructor" );
    }
}

private class MockTarget extends MockDependencyInjector
{
    public function new()
    {
		super();
    }
}