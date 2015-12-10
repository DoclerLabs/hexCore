package hex.event;

import hex.error.UnsupportedOperationException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightListenerDispatcher<ListenerType:IEventListener, EventType:Event> implements IEventDispatcher<ListenerType, EventType>
{
    private var _listeners : Array<ListenerType>;

    public function new<ListenerType>()
    {
        this._listeners = [];
    }

    public function dispatchEvent( event : EventType ) : Void
    {
        var eventType : String = event.type;
		var listeners = this._listeners.copy();

        for ( listener in listeners )
        {
            var callback = Reflect.field( listener, eventType );
            if ( callback != null )
            {
				Reflect.callMethod ( listener, callback, [ event ] );
            }
			else
			{
				var handleEvent = Reflect.field( listener, "handleEvent" );
				if ( handleEvent != null )
				{
					Reflect.callMethod ( listener, handleEvent, [ event ] );
				}
				else
				{
					var msg : String = Stringifier.stringify( this ) + ".dispatchEvent failed. " +
					" You must implement '" + eventType + "' method or 'handleEvent' method in '" +
					Stringifier.stringify( listener ) + "' instance.";
					throw( new UnsupportedOperationException( msg ) );
				}
			}
        }
    }

    public function addEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        throw ( new UnsupportedOperationException( "'addEventListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }

    public function removeEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        throw ( new UnsupportedOperationException( "'removeEventListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }

    public function addListener( listener : ListenerType ) : Bool
    {
        var index : Int = this._listeners.indexOf( listener );
        if ( index == -1 )
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
        if ( index == -1 )
        {
            return false;
        }
        else
        {
            this._listeners.splice( index, 1 );
            return true;
        }
    }

    public function removeAllListeners() : Void
    {
        this._listeners = [];
    }

    public function isEmpty() : Bool
    {
        return this._listeners.length == 0;
    }

    public function isRegistered( listener : ListenerType, ?eventType : String ) : Bool
    {
        return this._listeners.indexOf( listener ) != -1;
    }

    public function hasEventListener( eventType : String, ?callback : EventType->Void  ) : Bool
    {
        throw ( new UnsupportedOperationException( "'hasEventListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }
}
