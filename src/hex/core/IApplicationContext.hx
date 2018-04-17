package hex.core;

import hex.di.IDependencyInjector;
import hex.module.IContextModule;

/**
 * @author Francis Bourre
 */
interface IApplicationContext extends IContextModule
{
	function getName() : String;
	
	function getCoreFactory() : ICoreFactory;
	
	function getInjector() : IDependencyInjector;
}