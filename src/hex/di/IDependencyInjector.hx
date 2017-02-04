package hex.di;

import hex.di.provider.IDependencyProvider;

/**
 * @author Francis Bourre
 */
interface IDependencyInjector extends IBasicInjector
{
    function hasDirectMapping( type : Class<Dynamic>, name:String = '' ) : Bool;

    function satisfies( type : Class<Dynamic>, name : String = '' ) : Bool;

    function injectInto( target : Dynamic ) : Void;

    function destroyInstance( instance : Dynamic ) : Void;
	
	function addListener( listener: IInjectorListener ) : Bool;

	function removeListener( listener: IInjectorListener ) : Bool;
	
	function getProvider( className : String, name : String = '' ) : IDependencyProvider;
}