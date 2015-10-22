package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
interface IEventDispatcher<ListenerType:IEventListener, EventType:IEvent>
{
    function dispatchEvent( event : EventType ) : Void;
    function addEventListener( eventType : String, callback : EventType->Void ) : Bool;
    function removeEventListener( eventType : String, callback : EventType->Void ) : Bool;
    function addListener( listener : ListenerType ) : Bool;
    function removeListener( listener : ListenerType ) : Bool;
    function removeAllListeners() : Void;
    function isEmpty() : Bool;
    function isRegistered( listener : ListenerType, ?eventType : String ) : Bool;
    function hasEventListener( eventType : String, ?callback : EventType->Void  ) : Bool;
}
