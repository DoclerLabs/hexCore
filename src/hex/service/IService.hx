package hex.service;

import hex.event.MessageType;

/**
 * @author Francis Bourre
 */
interface IService<ServiceConfigurationType:ServiceConfiguration>
{
	function createConfiguration() : Void;
	
	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Void;

	function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Void;
		
	function getConfiguration() : ServiceConfigurationType;

	function setConfiguration( configuration : ServiceConfigurationType ) : Void;
	
	function removeAllListeners() : Void;
}