package hex.control;
import hex.error.IllegalStateException;

/**
 * ...
 * @author Francis Bourre
 */
class AsyncResponder<ResultType> implements ICompletable<ResultType>
{
	var _result 			: ResultType;
	var _errorMessage 		: String;
	
	var _hasCompleted 		: Bool = false;
	var _hasFailed 			: Bool = false;
	
	var _completeResponder 	: Array<ResultType->Void>;
	var _failResponder 		: Array<String->Void>;
	
	public function new() 
	{
		this._completeResponder 	= [];
		this._failResponder 		= [];
		this._hasCompleted 				= false;
	}
	
	public function onComplete( callback : ResultType->Void ) : ICompletable<ResultType>
	{
		if ( !this._hasCompleted )
		{
			this._completeResponder.push( callback );
		}
		else
		{
			callback( this._result );
		}
		
		return this;
	}
	
	public function onFail( callback : String->Void ) : ICompletable<ResultType>
	{
		if ( !this._hasFailed )
		{
			this._failResponder.push( callback );
		}
		else
		{
			callback( this._errorMessage );
		}
		
		return this;
	}
	
	public function complete( result : ResultType ) : Void
	{
		if ( !this._hasCompleted && !this._hasFailed )
		{
			this._result = result;
			for ( responder in this._completeResponder )
			{
				responder( result );
			}
		}
		else
		{
			throw new IllegalStateException( 'this instance has already completed' );
		}
	}
	
	public function fail( errorMessage : String ) : Void
	{
		if ( !this._hasCompleted && !this._hasFailed )
		{
			this._errorMessage = errorMessage;
			this._hasFailed = true;
			for ( responder in this._failResponder )
			{
				responder( errorMessage );
			}
		}
		else
		{
			throw new IllegalStateException( 'this instance has already failed' );
		}
	}
}
