package hex.control;

import hex.error.IllegalStateException;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncHandler<ResultType> implements ICompletable<ResultType>
{
	var _completeResponder 	: Array<ResultType->Void>;
	var _failResponder 		: Array<String->Void>;
	
	public function new() 
	{
		this._completeResponder 	= [];
		this._failResponder 		= [];
	}
	
	public function onComplete( callback : ResultType->Void ) : ICompletable<ResultType>
	{
		this._completeResponder.push( callback );
		return this;
	}
	
	public function onFail( callback : String->Void ) : ICompletable<ResultType>
	{
		this._failResponder.push( callback );
		return this;
	}
	
	public function complete( result : ResultType ) : Void
	{
		for ( responder in this._completeResponder )
		{
			responder( result );
		}
	}
	
	public function fail( errorMessage : String ) : Void
	{
		for ( responder in this._failResponder )
		{
			responder( errorMessage );
		}
	}
}
