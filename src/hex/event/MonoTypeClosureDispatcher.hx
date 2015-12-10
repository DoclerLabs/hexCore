package hex.event;

import hex.error.IllegalArgumentException;

/**
 * ...
 * @author Francis Bourre
 */
class MonoTypeClosureDispatcher<EventType:Event>
{
    private var _eventType      	: String;
    private var _callbacks      	: Array<EventType->Void>;

    public function new( eventType : String )
    {
		this._eventType 			= eventType;
        this._callbacks         	= [];
    }

    public function dispatchEvent( e : EventType ) : Void
    {
		if ( e.type != this._eventType )
		{
				throw new IllegalArgumentException( this + ".dispatchEvent failed. '" + e.type +"' should be '" + this._eventType + "'" );
		}
		
		for ( f in this._callbacks )
		{
			f( e );
		}
    }

    public function addEventListener( callback : EventType->Void ) : Bool
    {
        var index : Int = this._callbacks.indexOf( callback );
        if ( index == -1 )
        {
            this._callbacks.push( callback );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function removeEventListener( callback : EventType->Void ) : Bool
    {
        var index : Int = this._callbacks.indexOf( callback );
        if ( index == -1 )
        {
            return false;
        }
        else
        {
            this._callbacks.splice( index, 1 );
            return true;
        }
    }

    public function removeAllListeners() : Void
    {
        this._callbacks = [];
    }

    public function isEmpty() : Bool
    {
        return this._callbacks.length == 0;
    }
}
