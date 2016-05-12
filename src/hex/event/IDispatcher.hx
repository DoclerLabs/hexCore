package hex.event;

/**
 * @author Francis Bourre
 */
interface IDispatcher<ListenerType:{}> extends IObservable
{
	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	function addListener( listener : ListenerType ) : Bool;
	function removeListener( listener : ListenerType ) : Bool;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
	function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool;
	function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool;
}