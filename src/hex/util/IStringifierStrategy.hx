package hex.util;

/**
 * ...
 * @author Francis Bourre
 */
interface IStringifierStrategy
{
    /**
	* @return String representation of passed-in target object.
	*/
    function stringify( target : Dynamic ) : String;
}
