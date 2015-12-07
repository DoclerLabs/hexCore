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

    public function new( type : String, target : ILocator<KeyType, ValueType, LocatorEvent<KeyType, ValueType>>, key : KeyType, ?value : ValueType )
    {
        super( type, target );

        this.key       = key;
        this.value     = value;
    }
	
	@:isVar public var key( get, null ) : KeyType = null;
	private function get_key() : KeyType
	{
		return this.key;
	}
	
	@:isVar public var value( get, null ) : ValueType = null;
	private function get_value() : ValueType
	{
		return this.value;
	}
}
