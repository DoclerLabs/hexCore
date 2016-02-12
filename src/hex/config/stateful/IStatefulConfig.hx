package hex.config.stateful;

import hex.di.IDependencyInjector;
import hex.event.IDispatcher;
import hex.module.IModule;

/**
 * ...
 * @author Francis Bourre
 */
interface IStatefulConfig
{
    function configure( injector : IDependencyInjector, dispatcher : IDispatcher<{}>, module : IModule ) : Void;
}
