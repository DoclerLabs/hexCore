package hex.control;

import hex.control.async.AsyncCallback;
import hex.control.async.Handler;
import hex.control.async.Expect;
import hex.control.async.Nothing;
import hex.error.Exception;
import hex.error.IllegalArgumentException;
import hex.error.IllegalStateException;
import hex.unittest.assertion.Assert;

using hex.util.ArrayUtil;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncCallbackTest 
{
	@Test( 'Test with argument result' )
	public function testWithArgumentResult() : Void
	{
		var result 	: String;
		var error 	: Exception;
		var cancel = false;
		
		//test completion
		var acb = _loadString( Result.DONE( 'test' ) )
			.onComplete( function(r) result = r )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.equals( 'test', result );
		Assert.isNull( error );
		Assert.isFalse( cancel );
		
		Assert.isTrue( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
		Assert.isFalse( acb.isCancelled );
		
		//test failure
		result = null;
		error = null;
		cancel = false;
		
		acb = _loadString( Result.FAILED( new Exception( 'message' ) ) )
			.onComplete( function(r) result = r )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.isInstanceOf( error, Exception );
		Assert.equals( 'message', error.message );
		Assert.isNull( result );
		Assert.isFalse( cancel );
		
		Assert.isTrue( acb.isFailed );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isCancelled );
		
		//test cancel
		result = null;
		error = null;
		cancel = false;
		
		acb = _loadString( Result.CANCELLED )
			.onComplete( function(r) result = r )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.isTrue( cancel );
		Assert.isNull( result );
		Assert.isNull( error );
		
		Assert.isTrue( acb.isCancelled );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
	}
	
	@Test( 'Test without argument result' )
	public function testWithoutArgumentResult() : Void
	{
		var result 	: Nothing;
		var error 	: Exception;
		var cancel = false;
		
		//test completion
		var acb = _load( Result.DONE( Nothing ) )
			.onComplete( function() result = Nothing )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.equals( Nothing, result );
		Assert.isNull( error );
		Assert.isFalse( cancel );
		
		Assert.isTrue( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
		Assert.isFalse( acb.isCancelled );
		
		//test failure
		result = null;
		error = null;
		cancel = false;
		
		acb = _load( Result.FAILED( new Exception( 'message' ) ) )
			.onComplete( function(r) result = r )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.isInstanceOf( error, Exception );
		Assert.equals( 'message', error.message );
		Assert.isNull( result );
		Assert.isFalse( cancel );
		
		Assert.isTrue( acb.isFailed );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isCancelled );
		
		//test cancel
		result = null;
		error = null;
		cancel = false;
		
		acb = _load( Result.CANCELLED )
			.onComplete( function(r) result = r )
			.onFail( function(e) error = e )
			.onCancel( function() cancel = true );

		Assert.isTrue( cancel );
		Assert.isNull( result );
		Assert.isNull( error );
		
		Assert.isTrue( acb.isCancelled );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
	}
	
	@Test( 'Test completion twice' )
	public function testCompletionTwice() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Nothing );
			handler( Nothing );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test failure twice' )
	public function testFailureTwice() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( new Exception( 'message' ) );
			handler( new Exception( 'message' ) );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isFailed );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test cancel twice' )
	public function tesCancelTwice() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Result.CANCELLED );
			handler( Result.CANCELLED );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCancelled );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
	}
	
	@Test( 'Test completion and failure at the same time' )
	public function testCompletionAndFailureAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Nothing );
			handler( new Exception( 'message' ) );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test failure and completion at the same time' )
	public function testFailureAndCompletionAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( new Exception( 'message' ) );
			handler( Nothing );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isFailed );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test completion and cancel at the same time' )
	public function testCompletionAndCancelAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Nothing );
			handler( Result.CANCELLED );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test completion and cancel at the same time' )
	public function testCancelAndCompletionAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Result.CANCELLED );
			handler( Nothing );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCancelled );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
	}
	
	@Test( 'Test failure and cancel at the same time' )
	public function testFailureAndCancelAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( new Exception( 'message' ) );
			handler( Result.CANCELLED );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isFailed );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isCancelled );
	}
	
	@Test( 'Test cancel and failure at the same time' )
	public function testCancelAndFailureAtTheSameTime() : Void
	{
		var error : IllegalStateException = null;
		var acb : AsyncCallback<Nothing> = null;
		var handler : Handler<Nothing> = null;
		
		acb = AsyncCallback.get
		(
			function ( h : Handler<Nothing> )
			{
				handler = h;
			}
		);
		
		try 
		{
			handler( Result.CANCELLED );
			handler( new Exception( 'message' ) );
		}
		catch ( e : IllegalStateException )
		{
			error = e;
		}

		Assert.isInstanceOf( error, IllegalStateException );
		
		Assert.isTrue( acb.isCancelled );
		Assert.isFalse( acb.isCompleted );
		Assert.isFalse( acb.isFailed );
	}
	
	@Test( "test simple lambda chaining" )
	public function testSimpleLambdaChaining() 
	{
		var  r0 = 0;
		var  r1 = 0;
		
		var async = AsyncCallback.get
		(
			function ( handler : Handler<Int> )
			{
				handler( 4 );
			}
		);
		
		async
			.whenComplete( i => r0 = 3 + i )
			.whenComplete( j => r1 = r0 * 2 );
		
		Assert.equals( 7, r0, "result0 should be 3 + 4" );
		Assert.equals( 14, r1, "result1 should be 7 * 2" );
	}
	
	@Test( "test try catch" )
	public function testTryCatch() 
	{
		var error : Exception = null;
		var  r0 = 0.0;

		
		var async = AsyncCallback.get
		(
			function ( handler : Handler<Float> )
			{
				try
				{
					var a = [];
					handler( a[2] );
				}
				catch ( e : Dynamic )
				{
					handler( new IllegalArgumentException( 'message' ) );
				}
			}
		);
		
		async
			.whenComplete( i => r0 = 3 + i )
			.onFail( function(e) { error = e; } );
		
		Assert.isInstanceOf( error, IllegalArgumentException );
		Assert.equals( 'message', error.message );
		Assert.equals( 0.0, r0 );
	}
	
	@Test( "test chaining with ArrayUtil" )
	public function testChainingWithArrayUtil() 
	{
		var collection = [ for ( i in 0...10 ) { id: i, name: "user_" + i, isMember: i % 2 == 0 } ];
		
		var async = AsyncCallback.get
		(
			function ( handler : Handler<Array<User>> )
			{
				handler( collection );
			}
		);
		
		async
			.whenComplete( a => a.forEach( e => e.name += "Test" ) )
			.whenComplete( a => collection = a.filters( e => e.isMember ) )
			.whenComplete( a => a.forEach( e => if ( e.id > 5 ) collection.remove( e ) ) );

		Assert.deepEquals( 
			[
				{ id:0, name: "user_0Test", isMember: true },
				{ id:2, name: "user_2Test", isMember: true },
				{ id:4, name: "user_4Test", isMember: true }
			]
			, collection, "collection content should be the same" );
	}
	
	static function _load( result : Result<Nothing> ) : Expect<Nothing>
	{
		return AsyncCallback.get
		(
			function ( handler : Handler<Nothing> )
			{
				handler( result );
			}
		);
	}
	
	static function _loadString( result : Result<String> ) : Expect<String>
	{
		return AsyncCallback.get
		(
			function ( handler : Handler<String> )
			{
				handler( result );
			}
		);
	}
}

typedef User =
{
	var id : Int;
	var name : String;
	var isMember : Bool;
}