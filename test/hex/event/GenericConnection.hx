package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
interface GenericConnection<U>
{
	function onChangeValue( value : U ) : Void;
}