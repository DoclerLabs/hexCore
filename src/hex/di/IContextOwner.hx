package hex.di;

/**
 * ...
 * @author Francis Bourre
 */
interface IContextOwner
{
	function getBasicInjector() : IBasicInjector;
}