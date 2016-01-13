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
	
	public function call( data : Array<Dynamic> ) : Void
	{
		Reflect.callMethod( this.scope, this.callback, data );
	}
}