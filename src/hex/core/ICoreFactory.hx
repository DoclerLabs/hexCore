package hex.core;

import hex.collection.ILocator;
import hex.di.IDependencyInjector;
import hex.core.CoreFactoryVODef;

/**
 * @author Francis Bourre
 */
interface ICoreFactory extends ILocator<String, Dynamic>
{
	function getInjector() : IDependencyInjector;
	function clear() : Void;
	function buildInstance( constructorVO : CoreFactoryVODef ) : Dynamic;
	function fastEvalFromTarget( target : Dynamic, toEval : String ) : Dynamic;
	function addProxyFactoryMethod( classPath : String, scope : Dynamic, factoryMethod : Dynamic ) : Void;
	function removeProxyFactoryMethod( classPath : String ) : Bool;
	function hasProxyFactoryMethod( className : String ) : Bool;
}