package hex.module;

import hex.domain.Domain;
import hex.event.MessageType;
import hex.log.ILogger;

/**
 * ...
 * @author Francis Bourre
 */
interface IModule extends IContextModule
{
    function dispatchPublicMessage( messageType : MessageType, ?data : Array<Dynamic> ) : Void;

    function addHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function ) : Void;

    function removeHandler( messageType : MessageType, scope : Dynamic, callback : haxe.Constraints.Function ) : Void;
}
