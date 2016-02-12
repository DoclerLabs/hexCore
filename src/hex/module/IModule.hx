package hex.module;

import hex.di.IContextOwner;
import hex.domain.Domain;
import hex.event.MessageType;
import hex.log.ILogger;

/**
 * ...
 * @author Francis Bourre
 */
interface IModule extends IContextOwner
{
    function initialize() : Void;

    var isInitialized( get, null ) : Bool;
	
	function release() : Void;

	var isReleased( get, null ) : Bool;

    function dispatchPublicMessage( messageType : MessageType, ?data : Array<Dynamic> ) : Void;

    function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Void;

    function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Void;
	
	function getDomain() : Domain;
	
	function getLogger() : ILogger;
}
