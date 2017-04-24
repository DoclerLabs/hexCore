package hex.config.stateful;

import hex.di.IDependencyInjector;
import hex.module.IContextModule;

/**
 * ...
 * @author Francis Bourre
 */
interface IStatefulConfig
{
    function configure( injector : IDependencyInjector, module : IContextModule ) : Void;
}
