package hex.control.async;

import hex.error.Exception;

/**
 * @author Francis Bourre
 */

interface Expect<ResultType>
{
	function onComplete( onComplete : Callback<ResultType> ) : Expect<ResultType>;
	function onFail( onFail : Exception->Void ) : Expect<ResultType>;
	function onCancel( onCancel : Void->Void ) : Expect<ResultType>;
	
	var isWaiting( get, null ) : Bool;
	var isCompleted( get, null ) : Bool;
	var isFailed( get, null ) : Bool;
	var isCancelled( get, null ) : Bool;
}