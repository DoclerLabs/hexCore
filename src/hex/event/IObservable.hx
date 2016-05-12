package hex.event;

/**
 * @author Francis Bourre
 */
interface IObservable 
{
  	function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
	function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool;
}