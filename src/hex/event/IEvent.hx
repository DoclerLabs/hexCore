package hex.event;

/**
 * @author Francis Bourre
 */
interface IEvent 
{
	var type     : String;
	var target   : Dynamic;

    function clone() : IEvent;
    function toString() : String;
}