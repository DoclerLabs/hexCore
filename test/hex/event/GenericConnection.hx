package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
interface GenericConnection<U>
{
	@:astSource
	function onChangeValue( value : U ) : Void;
}