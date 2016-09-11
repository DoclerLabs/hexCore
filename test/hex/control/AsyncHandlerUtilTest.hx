package hex.control;
import hex.unittest.assertion.Assert;

using hex.control.AsyncHandlerUtil;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncHandlerUtilTest
{
	@Test( "test simple lambda" )
	public function testLambda() 
	{
		var  result = 0;
		
		var handler = new AsyncHandler<Int>();
		handler.on( i => result = i + 3 );
		handler.complete( 4 );
		
		Assert.equals( 7, result, "result should be sum of arg and 3" );
	}
}