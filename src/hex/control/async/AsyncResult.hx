package hex.control.async;

using tink.CoreApi;

/**
 * ...
 * @author Francis Bourre
 */
abstract AsyncResult<ResultType, Failure>( Result<ResultType, Failure> ) from ( Result<ResultType, Failure> )
{
	inline function new( r )
	{
		this = r;
	}

	@:from public static inline function completed<ResultType, Failure>( result : ResultType ) : AsyncResult<ResultType, Failure> 
	{
		return new AsyncResult( Result.DONE( result ) );
	}
	
	@:from public static inline function failed<ResultType, Failure>( error : Failure ) : AsyncResult<ResultType, Failure> 
	{
	return new AsyncResult( Result.FAILED( error ) );
	}
}

enum Result<T, E>
{
	WAITING;
	DONE( result : T );
	FAILED( e : E );
	CANCELLED;
}