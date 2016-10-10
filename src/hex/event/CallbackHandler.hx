package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CallbackHandler
{
	public var scope 		: Dynamic;
	public var callbacks	: Array<Dynamic> = [];

	public function new( scope : Dynamic, callback : Array<Dynamic> ) 
	{
		this.scope = scope;
		this.callbacks.push( callback );
	}
	
	public function call( data : Dynamic ) : Void
	{
		for ( callback in this.callbacks )
		{
			Reflect.callMethod( this.scope, callback, data );
		}
	}
	
	public function add( callback : Dynamic ) : Bool
	{
		#if !neko
		if ( this.callbacks.indexOf( callback ) == -1 )
		{
			this.callbacks.push( callback );
			return true;
		}
		else
		{
			return false;
		}
		#else
		for ( method in callbacks )
		{
			if ( Reflect.compareMethods( method, callback ) )
			{
				return false;
			}
		}
		
		this.callbacks.push( callback );
		return true;
		#end
	}
	
	public function remove( callback : Dynamic ) : Bool
	{
		#if !neko
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
		#else
		var length = this.callbacks.length;
		for ( index in 0...length )
		{
			var method = this.callbacks[ index ];
			if ( Reflect.compareMethods( method, callback ) )
			{
				this.callbacks.splice( index, 1 );
				return true;
			}
		}
		
		return false;
		#end
	}
	
	public function isEmpty() : Bool
	{
		return this.callbacks.length == 0;
	}
}