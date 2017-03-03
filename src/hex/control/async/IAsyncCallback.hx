package hex.control.async;

import hex.error.Exception;

/**
 * @author Francis Bourre
 */

interface IAsyncCallback<ResultType>
{
	function onComplete( onComplete : Callback<ResultType> ) : IAsyncCallback<ResultType>;
	function onFail( onFail : Exception->Void ) : IAsyncCallback<ResultType>;
}