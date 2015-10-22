package hex.event;

import Lambda;
import hex.log.Stringifier;
import hex.error.IllegalArgumentException;
import hex.error.UnsupportedOperationException;

/**
 * ...
 * @author Francis Bourre
 */
class EventDispatcher<ListenerType:IEventListener, EventType:IEvent> implements IEventDispatcher<ListenerType, EventType>
{
    private var _listeners : Map<ListenerType, Map<String, EventType->Void>>;

    public function new()
    {
        this._listeners = new Map();
    }

    public function dispatchEvent( e : EventType ) : Void
    {
        var eventType : String = e.type;
		
        var iterator = this._listeners.keys();
        while ( iterator.hasNext() )
        {
            var listener : ListenerType            = iterator.next();
            var m : Map<String, EventType->Void>   = this._listeners.get( listener );
			
            if ( Lambda.count( m ) > 0 )
            {
				if ( m.exists( eventType ) )
				{
					m.get( eventType )( e );
				}
            }
            else
            {
                var callback = Reflect.field( listener, eventType );
                if ( callback != null )
                {
                    Reflect.callMethod ( listener, callback, [ e ] );
                }
                else
                {
                    var handleEvent = Reflect.field( listener, "handleEvent" );
                    if ( handleEvent != null )
                    {
                        Reflect.callMethod ( listener, handleEvent, [ e ] );
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

    }

    public function addEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        var listener : Dynamic = Reflect.field( callback, "scope" );
        if ( this._listeners.exists( listener ) )
        {
            var m : Map<String, EventType->Void> = this._listeners.get( listener );

            if ( Lambda.count( m ) == 0 )
            {
                var msg : String = Stringifier.stringify( this ) + ".addEventListener failed. " +
				Stringifier.stringify( listener ) + " is already registered for all event types.";
				throw ( new IllegalArgumentException( msg ) );
            }
            else if ( m.exists( eventType ) )
            {
                return false;
            }
            else
            {
                m.set( eventType, callback );
                return true;
            }
        }
        else
        {
            var m : Map<String, EventType->Void> = new Map();
            m.set( eventType, callback );
            this._listeners.set( listener, m );
            return true;
        }
    }

    public function removeEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        var listener : Dynamic = Reflect.field( callback, "scope" );
        if ( this._listeners.exists( listener ) )
        {
            var m : Map<String, EventType->Void> = this._listeners.get( listener );

            if ( Lambda.count( m ) == 0 )
            {
                var msg : String = Stringifier.stringify( this ) + ".removeEventListener failed. " +
                Stringifier.stringify( listener ) + " is registered for all event types." +
                " Use removeListener to unsubscribe.";
                throw ( new IllegalArgumentException( msg ) );
            }
            else if ( m.exists( eventType ) )
            {
                m.remove( eventType );
                if ( Lambda.count( m ) == 0 )
                {
                    this._listeners.remove( listener );
                }
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    public function addListener( listener : ListenerType ) : Bool
    {
        if ( this._listeners.exists( listener ) )
        {
            var m : Map<String, EventType->Void> = this._listeners.get( listener );
            if ( Lambda.count( m ) > 0 )
            {
                var msg : String = Stringifier.stringify( this ) + ".addListener failed. " +
                Stringifier.stringify( listener ) + " is already registered to ";
                var iterator = m.keys();
                while ( iterator.hasNext() )
                {
                    msg += "'" + iterator.next() + "' ";
                }
                msg += "event types.";

                throw ( new IllegalArgumentException( msg ) );
            }
            else
            {
                return false;
            }
        }
        else
        {
            this._listeners.set( listener, new Map<String, EventType->Void>() );
            return true;
        }
    }

    public function removeListener( listener : ListenerType ) : Bool
    {
        if ( this._listeners.exists( listener ) )
        {
            this._listeners.remove( listener );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function removeAllListeners() : Void
    {
        this._listeners = new Map();
    }

    public function isEmpty() : Bool
    {
        return Lambda.count( this._listeners ) == 0;
    }

    public function isRegistered( listener : ListenerType, ?eventType : String ) : Bool
    {
        if ( this._listeners.exists( listener ) )
        {
            if ( eventType == null )
            {
                return true;
            }
            else
            {
                var m : Map<String, EventType->Void> = this._listeners.get( listener );
                return m.exists( eventType );
            }
        }
        else
        {
            return false;
        }
    }

    public function hasEventListener( eventType : String, ?callback : EventType->Void  ) : Bool
    {
        if ( callback == null )
        {
            var iterator = this._listeners.keys();
            while ( iterator.hasNext() )
            {
                var listener : ListenerType = iterator.next();
				var m : Map<String, EventType->Void> = this._listeners.get( listener );
				if ( Lambda.count( m ) == 0 )
				{
					return true;
				}
				else if ( m.exists( eventType ) )
                {
                    return true;
                }
            }

            return false;
        }
        else
        {
            var listener : Dynamic = Reflect.field( callback, "scope" );
            if ( this._listeners.exists( listener ) )
            {
                return true;
            }
            else
            {
                return false;
            }
        }
    }
}
