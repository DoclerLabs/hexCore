package hex.collection;

/**
 * ...
 * @author Francis Bourre
 */
interface ILocatorListener<KeyType, ValueType>
{
    function onRegister( key : KeyType, value : ValueType ) : Void;
    function onUnregister( key : KeyType ) : Void;
}
