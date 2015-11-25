package hex.domain;

import hex.event.IEvent;
import hex.event.IEventDispatcher;
import hex.event.IEventListener;

/**
 * @author Francis Bourre
 */

interface IDomainDispatcher<ListenerType:IEventListener, EventType:IEvent>
{
	
	function setDispatcherClass( ?dispatcherClass : Class<IEventDispatcher<ListenerType, EventType>> ) : Void;

    function getDefaultDispatcher() : IEventDispatcher<ListenerType, EventType>;

    function getDefaultDomain() : Domain;

    function setDefaultDomain( domain : Domain = null ) : Void;

    function clear() : Void;

    function isRegistered( listener : ListenerType, eventType : String, domain : Domain ) : Bool;

    function hasChannelDispatcher( ?domain : Domain ) : Bool;

    function getDomainDispatcher( ?domain : Domain ) : IEventDispatcher<ListenerType, EventType>;

    function releaseDomainDispatcher( domain : Domain ) : Bool;

    function addListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function removeListener( listener : ListenerType, ?domain : Domain ) : Bool;

    function addEventListener( eventType : String, callback : EventType-> Void, domain : Domain ) : Bool;

    function removeEventListener( eventType : String, callback : EventType-> Void, domain : Domain ) : Bool;

    function dispatchEvent( event : EventType, domain : Domain ) : Void;

    function removeAllListeners() : Void;
}