package hex.control;
import haxe.Timer;
import hex.unittest.assertion.Assert;
import hex.unittest.runner.MethodRunner;

using hex.control.AsyncHandlerUtil;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncHandlerUtilTest
{
	var result : Int;
	
	@Test( "test simple lambda" )
	public function testSimpleLambda() 
	{
		var  result = 0;
		
		var handler = new AsyncHandler<Int>();
		handler.on( i => result = i + 3 );
		handler.complete( 4 );
		
		Assert.equals( 7, result, "result should be sum of arg and 3" );
	}
	
	@Async( "test lambda chaining" )
	public function testChainingLambdas() 
	{
		this.result = 0;
		
		var handler = new AsyncHandler<Int>();
		
		handler
			.on( i => this.result = i + 3 )
			.on( j => this.result *= 2 )
				.triggers ( new AsyncHandler<Int>()
							.on( l => this.result *= 20 )
							.on( l => this.result -= 1 )
				)
				.triggers ( new TimeoutIntHandler() )
								.on( l => this.result -= 3 
				)
				.onComplete( MethodRunner.asyncHandler( this._onChainingEnd ) );

			
		handler.complete( 4 );

		
	}
	
	private function _onChainingEnd() : Void
	{
		Assert.equals( 276, this.result, "result should be ((4 + 3) *20) -1 -3" );
	}
}

private class TimeoutIntHandler extends AsyncHandler<Int>
{
	public function new()
	{
		super();
	}
	
	override public function complete( i : Int ) : Void
	{
		Timer.delay( this._do.bind( i ), 100 );
	}
	
	private function _do( i : Int ) : Void
	{
		super.complete( i );
	}
}