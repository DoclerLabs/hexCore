package hex.event;

import haxe.Constraints.Function;
import hex.event.MessageType;

/**
 * @author Francis Bourre
 */
typedef DispatcherDef =
{
	function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
	function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool;
}