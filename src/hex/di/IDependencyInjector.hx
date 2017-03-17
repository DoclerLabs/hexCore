package hex.di;

import hex.di.provider.IDependencyProvider;

/**
 * @author Francis Bourre
 */
interface IDependencyInjector extends IBasicInjector
{
    function hasDirectMapping<T>( type : Class<T>, name : String = '' ) : Bool;

    function satisfies<T>( type : Class<T>, name : String = '' ) : Bool;

    function injectInto<T>( target : T ) : Void;

    function destroyInstance<T>( instance : T ) : Void;
	
	function addListener( listener: IInjectorListener ) : Bool;

	function removeListener( listener: IInjectorListener ) : Bool;
	
	function getProvider<T>( className : String, name : String = '' ) : IDependencyProvider<T>;
}