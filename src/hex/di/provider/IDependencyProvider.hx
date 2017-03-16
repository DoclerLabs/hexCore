package hex.di.provider;

/**
 * ...
 * @author Francis Bourre
 */
interface IDependencyProvider<T>
{
    function getResult( injector : IDependencyInjector ) : T;
	function destroy() : Void;
}
