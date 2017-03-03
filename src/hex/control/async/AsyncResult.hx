package hex.control.async;

import hex.control.async.AsyncCallback;

/**
 * ...
 * @author Francis Bourre
 */
abstract AsyncResult<ResultType>( Result<ResultType> ) from ( Result<ResultType> )
{
	inline function new( r )
	{
		this = r;
	}

	@:from public static inline function completed<ResultType>( result : ResultType ) : AsyncResult<ResultType> 
	{
		return new AsyncResult( Result.DONE( result ) );
	}
	
	@:from public static inline function failed<ResultType>( error : hex.error.Exception ) : AsyncResult<ResultType> 
	{
		return new AsyncResult( Result.FAILED( error) );
	}
}