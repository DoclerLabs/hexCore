package hex.event;

import haxe.Constraints.Function;

/**
 * ...
 * @author Francis Bourre
 */
class FullClosureDispatcher extends ClosureDispatcher
{
	var _fullCallbacks : Array<MessageType->(Array<Dynamic>)->Void>;

	public function new()
    {
        super();
		this._fullCallbacks = [];
    }
	
	public function addHandlerForAll( callback : MessageType-> (Array<Dynamic>)->Void ) : Bool
	{
		if ( this._fullCallbacks.indexOf( callback ) == -1 )
		{
			this._fullCallbacks.push( callback );
			return true;
		}
		else 
		{
			return false;
		}
	}
	
  	public function removeHandlerForAll( callback : MessageType-> (Array<Dynamic>)->Void ) : Bool
	{
		var index = this._fullCallbacks.indexOf( callback );
		if ( index != -1 )
		{
			this._fullCallbacks.splice( index, 1 );
			return true;
		}
		else 
		{
			return false;
		}
	}
	
	override public function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void
    {
        super.dispatch( messageType, data );
		
		for ( callback in this._fullCallbacks )
		{
			callback( messageType, data );
		}
    }

	override public function removeAllListeners() : Void
    {
		super.removeAllListeners();
		this._fullCallbacks 	= [];
    }

	override public function isEmpty() : Bool
    {
        return super.isEmpty() && this._fullCallbacks.length == 0;
    }

    override public function hasHandler( messageType : MessageType, ?callback : Function ) : Bool
    {
		if ( this._fullCallbacks.length > 0 )
		{
			return true;
		}
        else
		{
			return super.hasHandler( messageType, callback );
		}
    }
}