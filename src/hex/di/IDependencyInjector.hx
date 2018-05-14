package hex.di;

import hex.di.provider.IDependencyProvider;

/**
 * @author Francis Bourre
 */
interface IDependencyInjector extends IBasicInjector
{
    function hasDirectMapping<T>( type : ClassRef<T>, ?name : MappingName) : Bool;

    function satisfies<T>( type : ClassRef<T>, ?name : MappingName ) : Bool;

    function injectInto( target : IInjectorAcceptor ) : Void;

    function destroyInstance<T>( instance : T ) : Void;
	
	function addListener( listener: IInjectorListener ) : Bool;

	function removeListener( listener: IInjectorListener ) : Bool;
	
	function getProvider<T>( className : ClassName, ?name : MappingName ) : IDependencyProvider<T>;
}