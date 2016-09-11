package hex.control;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ASyncResponderTest
{
	@Test( "test complete" )
	public function testComplete() 
	{
		var responder = new MockStringResponder();
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
		var responder = new MockFailureResponder();
		var result : String = "";
		var error : String = "";
		
		responder.onComplete( function( s : String) { result = s; } ).onFail( function( e : String) { error = e; } );
		responder.complete( "hello" );
		
		Assert.equals( "", result, "result should not be setted" );
		Assert.equals( "error", error, "error should be passed" );
	}
	
}

private class MockStringResponder extends ASyncResponder<String>
{
	public function new()
	{
		super();
	}
	
	public function complete( s : String )
	{
		this._complete( "hello" );
	}
}

private class MockFailureResponder extends ASyncResponder<String>
{
	public function new()
	{
		super();
	}
	
	public function complete( s : String )
	{
		this._fail( "error" );
	}
}