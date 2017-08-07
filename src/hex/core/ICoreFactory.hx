package hex.core;

import hex.collection.ILocator;
import hex.di.IDependencyInjector;

/**
 * @author Francis Bourre
 */
interface ICoreFactory extends ILocator<String, Dynamic>
{
	function getInjector() : IDependencyInjector;
	function clear() : Void;
}