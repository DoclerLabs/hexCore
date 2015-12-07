package hex.collection;

import hex.event.IEvent;

/**
 * ...
 * @author Francis Bourre
 */
interface ILocator<KeyType, ValueType, EventType:IEvent>
{
    function keys() : Array<KeyType>;

    function values() : Array<ValueType>;

    function isRegisteredWithKey( key : KeyType ) : Bool;

    function locate( key : KeyType ) : ValueType;

    function register( key : KeyType, element : ValueType ) : Bool;

    function unregister( key : KeyType ) : Bool;

    function add( map : Map<KeyType, ValueType> ) : Void;

    function addListener( listener : ILocatorListener<EventType> ) : Bool;

    function removeListener( listener : ILocatorListener<EventType> ) : Bool;
}
