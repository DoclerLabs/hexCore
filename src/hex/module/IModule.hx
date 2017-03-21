package hex.module;

import hex.domain.Domain;
import hex.event.MessageType;
import hex.log.ILogger;

/**
 * ...
 * @author Francis Bourre
 */
interface IModule extends IContextModule
{
    //function initialize() : Void;

    //var isInitialized( get, null ) : Bool;
	
	//function release() : Void;

	//var isReleased( get, null ) : Bool;

    function dispatchPublicMessage( messageType : MessageType, ?data : Array<Dynamic> ) : Void;

    function addHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Void;

    function removeHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Void;
	
	//function getDomain() : Domain;
	
	//function getLogger() : ILogger;
	
	/*var isInitialized( get, null ) : Bool;
	var isReleased( get, null ) : Bool;
	
	function initialize() : Void;
	function release() : Void;
	
	function getDomain() : Domain;
	function getInjector() : IDependencyInjector;
	function getLogger() : ILogger;*/
}
