package hex.control;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncResponderTest
{
	@Test( "test complete" )
	public function testComplete() 
	{
		var responder = new AsyncResponder<String>();
		var result : String = "";
		var error : String = "";
		
		responder.onComplete( function( s : String) { result = s; } ).onFail( function( e : String) { error = e; } );
		responder.complete( "hello" );
		
		Assert.equals( "hello", result, "result should be passed");
		Assert.equals( "", error, "error should not be setted" );
	}
	
	@Test( "test fail" )
	public function testFail() 
	{
		var responder = new AsyncResponder<String>();
		var result : String = "";
		var error : String = "";
		
		responder.onComplete( function( s : String) { result = s; } ).onFail( function( e : String) { error = e; } );
		responder.fail( "error" );
		
		Assert.equals( "", result, "result should not be setted" );
		Assert.equals( "error", error, "error should be passed" );
	}
	
}