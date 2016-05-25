package hex.di;

/**
 * ...
 * @author Francis Bourre
 */
interface IContextOwner
{
	function getInjector() : IDependencyInjector;
}