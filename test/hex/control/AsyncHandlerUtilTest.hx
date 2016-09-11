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
	public function testSimpleLambda() 
	{
		var  result = 0;
		
		var handler = new AsyncHandler<Int>();
		handler.on( i => result = i + 3 );
		handler.complete( 4 );
		
		Assert.equals( 7, result, "result should be sum of arg and 3" );
	}
	
	@Test( "test lambda chaining" )
	public function testChainingLambdas() 
	{
		var  result0 = 0;
		var  result1 = 0;
		
		var handler = new AsyncHandler<Int>();
		
		handler
			.on( i => { result0 = i + 3; } )
			.on( j => { result1 = result0 * 2; } );
			
		handler.complete( 4 );
		
		Assert.equals( 7, result0, "result0 should be sum of arg and 3" );
		Assert.equals( 14, result1, "result1 should be sum of arg and 1" );
	}
}