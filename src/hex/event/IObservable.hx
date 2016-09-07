package hex.event;

/**
 * @author Francis Bourre
 */
interface IObservable 
{
  	function addHandler( messageType : MessageType, callback : Dynamic ) : Bool;
	function removeHandler( messageType : MessageType, callback : Dynamic ) : Bool;
}