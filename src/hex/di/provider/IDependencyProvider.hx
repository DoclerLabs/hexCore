package hex.di.provider;

/**
 * ...
 * @author Francis Bourre
 */
interface IDependencyProvider
{
    function getResult( injector : IDependencyInjector ) : Dynamic;
	function destroy() : Void;
}
