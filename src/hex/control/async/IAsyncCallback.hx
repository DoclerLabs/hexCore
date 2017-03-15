package hex.control.async;

import hex.error.Exception;

/**
 * @author Francis Bourre
 */

interface IAsyncCallback<ResultType>
{
	function onComplete( onComplete : Callback<ResultType> ) : IAsyncCallback<ResultType>;
	function onFail( onFail : Exception->Void ) : IAsyncCallback<ResultType>;
	function onCancel( onCancel : Void->Void ) : IAsyncCallback<ResultType>;
	
	var isWaiting( get, null ) : Bool;
	var isCompleted( get, null ) : Bool;
	var isFailed( get, null ) : Bool;
	var isCancelled( get, null ) : Bool;
}