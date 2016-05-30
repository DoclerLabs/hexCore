package hex.event;

/**
 * @author Francis Bourre
 */
typedef Event =
{
	public var type     : String;
    public var target   : Dynamic;
	function clone()	: Event;	
	function toString()	: String;	
}