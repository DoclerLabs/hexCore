package hex.core;

import hex.collection.ILocator;
import hex.core.CoreFactoryVODef;
import hex.di.IDependencyInjector;

/**
 * @author Francis Bourre
 */
interface ICoreFactory extends ILocator<String, Dynamic>
{
	function getInjector() : IDependencyInjector;
	function clear() : Void;
	function buildInstance( constructorVO : CoreFactoryVODef ) : Dynamic;
	function fastEvalFromTarget( target : Dynamic, toEval : String ) : Dynamic;
}