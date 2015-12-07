package hex.collection;

import hex.event.IEvent;
import hex.event.IEventListener;

/**
 * ...
 * @author Francis Bourre
 */
interface ILocatorListener<EventType:IEvent> extends IEventListener
{
    function onRegister( event : EventType ) : Void;
    function onUnregister( event : EventType ) : Void;
}
