package hex.di;

/**
 * @author Francis Bourre
 */
interface IInjectorListener 
{
	function onPreConstruct( target : IDependencyInjector, instance : Dynamic, instanceType : Class<Dynamic> ): Void;
	function onPostConstruct( target : IDependencyInjector, instance : Dynamic, instanceType : Class<Dynamic> ) : Void;
}