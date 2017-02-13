package hex.event;

/**
 * @author Francis Bourre
 */
interface IDispatcher<ListenerType:{}>
{
	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
	function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
	function addListener( listener : ListenerType ) : Bool;
	public function dispatchTyped<T>( messageType : TypedMessageType<T>, ?data : T ) : Void;
	function addHandlerTyped<T>( messageType : TypedMessageType<T>, scope : Dynamic, callback : T -> Void ) : Bool;
	function removeListener( listener : ListenerType ) : Bool;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
	function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool;
	function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool;
}