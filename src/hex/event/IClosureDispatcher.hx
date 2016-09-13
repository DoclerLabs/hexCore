package hex.event;

import haxe.Constraints.Function;

/**
 * @author Francis Bourre
 */
interface IClosureDispatcher 
{
    function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void;
    function addHandler( messageType : MessageType, callback : Function ) : Bool;
    function removeHandler( messageType : MessageType, callback : Function ) : Bool;
	function removeAllListeners() : Void;
	function isEmpty() : Bool;
    function hasHandler( messageType : MessageType, ?callback : Function ) : Bool;
}