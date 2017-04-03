package hex.di.provider;

/**
 * ...
 * @author Francis Bourre
 */
interface IDependencyProvider<T>
{
    function getResult( injector : IDependencyInjector, target : Class<Dynamic> ) : T;
	function destroy() : Void;
}
