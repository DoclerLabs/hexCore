package hex.event;

/**
 * @author Francis Bourre
 */
interface IDispatcher<ListenerType:{}>
{
	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	function addHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Bool;
	function removeHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Bool;
	function addListener( listener : ListenerType ) : Bool;
	function removeListener( listener : ListenerType ) : Bool;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
	function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool;
	function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool;
}