package hex.service.stateful;

import hex.event.CompositeDispatcher;
import hex.service.IService;

/**
 * @author Francis Bourre
 */
interface IStatefulService extends IService
{
	function inUse():Bool;
	function getDispatcher() : CompositeDispatcher;
}