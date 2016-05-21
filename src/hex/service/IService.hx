package hex.service;

import hex.event.IObservable;
import hex.event.MessageType;

/**
 * @author Francis Bourre
 */
interface IService extends IObservable
{
	function createConfiguration() : Void;
	
	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;

	function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
		
	function getConfiguration() : ServiceConfiguration;

	function setConfiguration( configuration : ServiceConfiguration ) : Void;
	
	function removeAllListeners() : Void;
}