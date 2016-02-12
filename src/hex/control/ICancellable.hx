package hex.control;
import hex.control.ICallable;

/**
 * @author Francis Bourre
 */

interface ICancellable extends ICallable
{
	function cancel() : Void;
}