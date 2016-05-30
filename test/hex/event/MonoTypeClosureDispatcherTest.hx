package hex.event;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author duke
 */
class MonoTypeClosureDispatcherTest
{

	public function new() 
	{
		
	}
	
    @Test( "Test dispatch method" )
    public function testDispatch() : Void
    {
        var target = new MockTarget();
        var e = new MonoTypeClosureDispatcher<BasicEvent>( "event", target );
		e.dispatchEvent();
    }
	
}

private class MockTarget
{
    public function new()
    {

    }
}