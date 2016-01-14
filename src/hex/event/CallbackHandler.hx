package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CallbackHandler
{
	public var scope 		: Dynamic;
	public var callbacks	: Array<Dynamic> = [];

	public function new( scope : Dynamic, callback : Dynamic ) 
	{
		this.scope = scope;
		this.callbacks.push( callback );
	}
	
	public function call( data : Array<Dynamic> ) : Void
	{
		for ( callback in this.callbacks )
		{
			Reflect.callMethod( this.scope, callback, data );
		}
	}
	
	public function add( callback : Dynamic ) : Bool
	{
		if ( this.callbacks.indexOf( callback ) == -1 )
		{
			this.callbacks.push( callback );
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function remove( callback : Dynamic ) : Bool
	{
		var index : Int = this.callbacks.indexOf( callback );
		if (  index != -1 )
		{
			this.callbacks.splice( index, 1 );
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function isEmpty() : Bool
	{
		return this.callbacks.length == 0;
	}
}