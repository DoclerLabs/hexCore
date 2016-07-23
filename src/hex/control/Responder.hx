package hex.control;

import hex.control.ICompletable;

/**
 * ...
 * @author Francis Bourre
 */
class Responder<ResultType> implements ICompletable<ResultType>
{
	var _completable : ICompletable<ResultType>;

	public function new( ?completable : ICompletable<ResultType> ) 
	{
		this._completable = completable;
	}
	
	public function onComplete( callback : ResultType->Void ) : ICompletable<ResultType>
	{
		this._completable.onComplete( callback );
		return this;
	}
	
	public function onFail( callback : String->Void ) : ICompletable<ResultType>
	{
		this._completable.onFail( callback );
		return this;
	}
}