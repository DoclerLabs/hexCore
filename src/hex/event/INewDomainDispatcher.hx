package hex.event;

import hex.domain.Domain;

/**
 * @author Francis Bourre
 */
interface INewDomainDispatcher<ListenerType:{}> 
{
	
	function setDispatcherClass( ?dispatcherClass : Class<IDispatcher<ListenerType>> ) : Void;

    function getDefaultDispatcher() : IDispatcher<ListenerType>;

    function getDefaultDomain() : Domain;

    function setDefaultDomain( domain : Domain = null ) : Void;

    function clear() : Void;

    function isRegistered( listener : ListenerType, messageType : MessageType, domain : Domain ) : Bool;

    function hasChannelDispatcher( ?domain : Domain ) : Bool;

    function getDomainDispatcher( ?domain : Domain ) : IDispatcher<ListenerType>;

    function releaseDomainDispatcher( domain : Domain ) : Bool;

    function addListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function removeListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic, domain : Domain ) : Bool;

    function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic, domain : Domain ) : Bool;

    function dispatch( messageType : MessageType, domain : Domain, data : Array<Dynamic> ) : Void;

    function removeAllListeners() : Void;
	
}