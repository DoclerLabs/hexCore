package hex.event;

/**
 * @author Francis Bourre
 */
interface IDispatcher<ListenerType:{}>
{
	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	function addHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function ) : Bool;
	function removeHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function ) : Bool;
	function addListener( listener : ListenerType ) : Bool;
	function removeListener( listener : ListenerType ) : Bool;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
	function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool;
	function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool;
}