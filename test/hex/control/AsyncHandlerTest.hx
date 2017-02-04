package hex.control;

import hex.error.IllegalStateException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncHandlerTest
{
	var result0 	: String;
	var result1 	: String;
	var error0 		: String;
	var error1 		: String;
	
	@Before
	function _init() : Void
	{
		result0 = "";
		result1 = "";
		error0 = "";
		error1 = "";
	}
		
	@Test( "test callbacks" )
	public function testCallbacks() 
	{
		var responder = new AsyncHandler<String>();

		responder
			.onComplete( function( s : String) { result0 = s; } )
			.onComplete( function( s : String) { result1 = s; } )
			.onFail( function( e : String) { error0 = e; } )
			.onFail( function( e : String) { error1 = e; } );
		
		responder.complete( "hello" );
		
		Assert.equals( "hello", result0, "result0 should be passed" );
		Assert.equals( "hello", result1, "result1 should be passed" );
		Assert.equals( "", error0, "error0 should not be setted" );
		Assert.equals( "", error1, "error1 should not be setted" );
		
		this._init();
		responder.complete( "hello2" );
		
		Assert.equals( "hello2", result0, "result0 should be passed" );
		Assert.equals( "hello2", result1, "result1 should be passed" );
		Assert.equals( "", error0, "error0 should not be setted" );
		Assert.equals( "", error1, "error1 should not be setted" );
		
		this._init();
		responder.fail( "error" );
		
		Assert.equals( "", result0, "result0 should not be setted" );
		Assert.equals( "", result1, "result1 should not be setted" );
		Assert.equals( "error", error0, "error0 should be passed" );
		Assert.equals( "error", error1, "error1 should be passed" );
		
		this._init();
		responder.fail( "error2" );
		
		Assert.equals( "", result0, "result0 should not be setted" );
		Assert.equals( "", result1, "result1 should not be setted" );
		Assert.equals( "error2", error0, "error0 should be passed" );
		Assert.equals( "error2", error1, "error1 should be passed" );
		
		this._init();
		responder.complete( "hello" );
		
		Assert.equals( "hello", result0, "result0 should be passed" );
		Assert.equals( "hello", result1, "result1 should be passed" );
		Assert.equals( "", error0, "error0 should not be setted" );
		Assert.equals( "", error1, "error1 should not be setted" );
	}
	
	@Test( "test callbacks" )
	public function testCallbackChaining() 
	{
		var responder = new AsyncHandler<Int>();
		var anotheResponder = new AsyncHandler<String>();
		
		var  intResult = 0;
		
		responder
			.onComplete( function( i : Int ) { anotheResponder.onComplete( function( s : String ) { result0 = ">" + s; } ); anotheResponder.complete( ">" + i );  } )
			.onComplete( function( i : Int ) { intResult = i; } )
			.onFail( function( e : String) { error0 = e; } )
			.onFail( function( e : String) { error1 = e; } );
		
		responder.complete( 3 );
		
		Assert.equals( ">>3", result0, "result0 should be passed" );
		Assert.equals( 3, intResult, "result1 should be passed" );
		Assert.equals( "", error0, "error0 should not be setted" );
		Assert.equals( "", error1, "error1 should not be setted" );
	}
}