package hex.event;

/**
 * @author Francis Bourre
 */
interface IDispatcher<ListenerType:Dynamic> 
{
	function dispatch( messageType : MessageType, data : Array<Dynamic> ) : Void;
	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
	function removeHandler( messageType : MessageType, callback : Dynamic ) : Bool;
}