package hex.collection;

import hex.event.BasicEvent;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorEvent<KeyType, ValueType> extends BasicEvent
{
    public inline static var REGISTER      : String = "onRegister";
    public inline static var UNREGISTER    : String = "onUnregister";

    private var  _key       : KeyType;
    private var  _value     : ValueType;

    public function new( type : String, target : ILocator<KeyType, ValueType>, key : KeyType, ?value : ValueType )
    {
        super( type, target );

        this._key       = key;
        this._value     = value;
    }

    public function getKey() : KeyType
    {
        return this._key;
    }

    public function getValue() : ValueType
    {
        return this._value;
    }
}
