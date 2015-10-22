package hex.collection;

import hex.event.IEventListener;

/**
 * ...
 * @author Francis Bourre
 */
interface ILocatorListener<KeyType, ValueType> extends IEventListener
{
    function onRegister( event : LocatorEvent<KeyType, ValueType> ) : Void;
    function onUnregister( event : LocatorEvent<KeyType, ValueType> ) : Void;
}
