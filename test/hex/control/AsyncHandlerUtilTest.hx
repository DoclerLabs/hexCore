package hex.control;

import haxe.Timer;
import hex.unittest.assertion.Assert;
import hex.unittest.runner.MethodRunner;

using hex.util.ArrayUtil;
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
	
	@Test( "test chaining with ArrayUtil" )
	public function testChainingWithArrayUtil() 
	{
		var collection = [ for ( i in 0...10 ) { id: i, name: "user_"+i, isMember: i%2==0 } ];

		var handler = new AsyncHandler<Array<User>>();
		
		handler
			.on( a => a.forEach( e => e.name += "Test" ) )
			.on( a => collection = a.findAll( e => e.isMember ) )
			.on( a => a.forEach( e => if ( e.id > 5 ) collection.remove( e ) ) );

			
		handler.complete( collection );

		Assert.deepEquals( 
			[
				{ id:0, name: "user_0Test", isMember: true },
				{ id:2, name: "user_2Test", isMember: true },
				{ id:4, name: "user_4Test", isMember: true }
			]
			, collection, "collection content should be the same" );
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

typedef User =
{
	var id : Int;
	var name : String;
	var isMember : Bool;
}