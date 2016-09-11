package hex.control;

import hex.control.ICompletable;
import hex.error.VirtualMethodException;

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
	
	public function complete( result : ResultType ) : Void
	{
		throw new VirtualMethodException( this + ".complete must be overridden" );
	}
	
	public function fail( error : String ) : Void
	{
		throw new VirtualMethodException( this + ".fail must be overridden" );
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