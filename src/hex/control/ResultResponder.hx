package hex.control;

import hex.error.VirtualMethodException;

/**
 * ...
 * @author Francis Bourre
 */
class ResultResponder<ResultType> implements ICompletable<ResultType>
{
	var _result 		: ResultType;
	var _errorMessage 	: String;

	//TODO make unit tests
	public function new( result : ResultType, errorMessage : String = "" ) 
	{
		this._result 		= result;
		this._errorMessage 	= errorMessage;
	}
	
	public function complete( result : ResultType ) : Void
	{
		throw new VirtualMethodException();
	}
	
	public function fail( error : String ) : Void
	{
		throw new VirtualMethodException();
	}
	
	public function onComplete( callback : ResultType->Void ) : ICompletable<ResultType>
	{
		callback( this._result );
		return this;
	}
	
	public function onFail( callback : String->Void ) : ICompletable<ResultType>
	{
		callback( this._errorMessage );
		return this;
	}
}