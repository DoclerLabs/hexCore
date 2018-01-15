package hex.error;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ExceptionTest 
{
	public function new() { }
	
	@Test( "Test 'name' property passed to constructor" )
    public function testConstructor() : Void
    {
        var e = new Exception( "message" );
        Assert.equals( "message", e.message );
        Assert.isNotNull( "message", e.name );
        Assert.isNotNull( "message", e.posInfos );
        Assert.isNotNull( "message", e.toString() );
    }
}