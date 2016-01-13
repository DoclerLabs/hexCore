package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class DynamicHandler
{
	public var scope 	: Dynamic;
	public var callback	: Dynamic;

	public function new( scope : Dynamic, callback : Dynamic ) 
	{
		this.scope 		= scope;
		this.callback 	= callback;
	}
}