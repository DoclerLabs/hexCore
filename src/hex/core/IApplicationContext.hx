package hex.core;

import hex.di.IContextOwner;
import hex.di.IDependencyInjector;
import hex.domain.Domain;
import hex.event.MessageType;
import hex.core.ICoreFactory;

/**
 * @author Francis Bourre
 */
interface IApplicationContext extends IContextOwner
{
	function getName() : String;
	
	function getDomain() : Domain;

	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	
	function getCoreFactory() : ICoreFactory;
	
	function getInjector() : IDependencyInjector;
}