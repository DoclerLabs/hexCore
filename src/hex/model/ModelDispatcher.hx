package hex.model;

/**
 * ...
 * @author Francis Bourre
 */
@:autoBuild( hex.model.ModelDispatcherAutoBuildMacro.build() )
class ModelDispatcher<ListenerType> implements IModelDispatcher<ListenerType>
{
	var _listeners : Array<ListenerType>;
	
	public function new() 
	{
		this._listeners = [];
		
	}

	public function addListener( listener : ListenerType ) : Bool
	{
		if ( this._listeners.indexOf( listener ) == -1 )
		{
			this._listeners.push( listener );
			return true;
		}
		else
		{
			return false;
		}
	}

	public function removeListener( listener : ListenerType ) : Bool
	{
		var index : Int = this._listeners.indexOf( listener );
		
		if ( index > -1 )
		{
			this._listeners.splice( index, 1 );
			return true;
		}
		else
		{
			return false;
		}
	}
}