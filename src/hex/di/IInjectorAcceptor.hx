package hex.di;

/**
 * @author Francis Bourre
 */

interface IInjectorAcceptor 
{
	function acceptInjector( i : IDependencyInjector ) : Void;
}