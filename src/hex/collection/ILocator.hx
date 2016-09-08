package hex.collection;

import hex.event.IObservable;

/**
 * ...
 * @author Francis Bourre
 */
interface ILocator<KeyType, ValueType> extends IObservable
{
    function keys() : Array<KeyType>;

    function values() : Array<ValueType>;

    function isRegisteredWithKey( key : KeyType ) : Bool;

    function locate( key : KeyType ) : ValueType;

    function register( key : KeyType, element : ValueType ) : Bool;

    function unregister( key : KeyType ) : Bool;

    function add( map : Map<KeyType, ValueType> ) : Void;

    function addListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool;

    function removeListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool;
}
