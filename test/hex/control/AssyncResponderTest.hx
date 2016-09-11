package hex.control;

import hex.control.AssyncResponder;
import hex.error.IllegalStateException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class AssyncResponderTest
{
	@Test( "test complete" )
	public function testComplete() 
	{
		var responder = new AssyncResponder<String>();
		
		var result0 : String = "";
		var result1 : String = "";
		var error0 : String = "";
		var error1 : String = "";
		
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
		
		Assert.methodCallThrows( IllegalStateException, responder, responder.complete, [ "another result" ], "second call should throw 'IllegalStateException'" );
		Assert.methodCallThrows( IllegalStateException, responder, responder.fail, [ "another error" ], "second call should throw 'IllegalStateException'" );
	}
	
	@Test( "test fail" )
	public function testFail() 
	{
		var responder = new AssyncResponder<String>();
		
		var result0 : String = "";
		var result1 : String = "";
		var error0 : String = "";
		var error1 : String = "";
		
		responder
			.onComplete( function( s : String) { result0 = s; } )
			.onComplete( function( s : String) { result1 = s; } )
			.onFail( function( e : String) { error0 = e; } )
			.onFail( function( e : String) { error1 = e; } );
			
		responder.fail( "error" );
		
		Assert.equals( "", result0, "result0 should not be setted" );
		Assert.equals( "", result1, "result1 should not be setted" );
		Assert.equals( "error", error0, "error0 should be passed" );
		Assert.equals( "error", error1, "error1 should be passed" );
		
		Assert.methodCallThrows( IllegalStateException, responder, responder.complete, [ "another result" ], "second call should throw 'IllegalStateException'" );
		Assert.methodCallThrows( IllegalStateException, responder, responder.fail, [ "another error" ], "second call should throw 'IllegalStateException'" );
	}
	
}