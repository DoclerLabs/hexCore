package hex.service;

import hex.event.IObservable;
import hex.event.MessageType;

/**
 * @author Francis Bourre
 */
interface IService<ServiceConfigurationType:ServiceConfiguration> extends IObservable
{
	function createConfiguration() : Void;
	
	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;

	function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
		
	function getConfiguration() : ServiceConfigurationType;

	function setConfiguration( configuration : ServiceConfigurationType ) : Void;
	
	function removeAllListeners() : Void;
}