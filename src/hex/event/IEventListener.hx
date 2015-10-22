package hex.event;

/**
 * @author Francis Bourre
 */
interface IEventListener 
{
	function handleEvent( e : IEvent ) : Void;
}