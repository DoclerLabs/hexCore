package hex.event;

import hex.error.UnsupportedOperationException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class EventDispatcher<ListenerType:IEventListener, EventType:IEvent> implements IEventDispatcher<ListenerType, EventType>
{
	private var _isSealed 			: Bool;
	private var _cachedMethodCalls 	: Array<Void->Void>;
    private var _listeners 			: Array<ListenerType>;
    private var _closures 			: Map<String, Array<EventType->Void>>;
    private var _closureSize 		: UInt;

    public function new()
    {
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
        this._listeners 			= [];
		this._closures         		= new Map();
        this._closureSize      		= 0;
    }

    public function dispatchEvent( e : EventType ) : Void
    {
		this._seal( true );
		
        var eventType : String = e.type;

		var listeners = this._listeners.copy();

        for ( listener in listeners )
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
		
		if ( this._closures.exists( eventType ) )
        {
			var callbacks = this._closures.get( eventType ).copy();
            for ( f in callbacks )
            {
                f( e );
            }
        }

		this._seal( false );
    }

    public function addEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( !this._closures.exists( eventType ) )
			{
				this._closures.set( eventType, [] );
			}

			var callbacks : Array<EventType->Void> = this._closures.get( eventType );
			var index : Int = callbacks.indexOf( callback );
			if ( index == -1 )
			{
				callbacks.push( callback );
				this._closureSize++;
				return true;
			}
			else
			{
				return false;
			}

		}
		else
		{
			this._cachedMethodCalls.push( this.addEventListener.bind( eventType, callback ) );
			return false;
		}
    }

    public function removeEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( !this._closures.exists( eventType ) )
			{
				return false;
			}

			var callbacks : Array<EventType->Void> = this._closures.get( eventType );
			var index : Int = callbacks.indexOf( callback );
			if ( index == -1 )
			{
				return false;
			}
			else
			{
				callbacks.splice( index, 1 );
				this._closureSize--;

				if ( callbacks.length == 0 )
				{
					this._closures.remove( eventType );
				}

				return true;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.removeEventListener.bind( eventType, callback ) );
			return false;
		}
    }

    public function addListener( listener : ListenerType ) : Bool
    {
		if ( !this._isSealed )
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
		else
		{
			this._cachedMethodCalls.push( this.addListener.bind( listener ) );
			return false;
		}
    }

    public function removeListener( listener : ListenerType ) : Bool
    {
		if ( !this._isSealed )
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
		else
		{
			this._cachedMethodCalls.push( this.removeListener.bind( listener ) );
			return false;
		}
    }

    public function removeAllListeners() : Void
    {
		if ( !this._isSealed )
		{
			this._listeners 	= [];
			this._closures 		= new Map();
			this._closureSize 	= 0;
		}
		else
		{
			this._cachedMethodCalls.push( this.removeAllListeners.bind() );
		}
    }

    public function isEmpty() : Bool
    {
		return this._listeners.length == 0 && this._closureSize == 0;
    }

    public function isRegistered( listener : ListenerType, ?eventType : String ) : Bool
    {
		return this._listeners.indexOf( listener ) != -1;
    }

    public function hasEventListener( eventType : String, ?callback : EventType->Void  ) : Bool
    {
		if ( !this._closures.exists( eventType ) )
        {
            return false;
        }

        if ( callback == null )
        {
            return true;
        }
        else
        {
            return this._closures.get( eventType ).indexOf( callback ) != -1;
        }
    }
	
	private function _seal( isSealed : Bool ) : Void
	{
		if ( isSealed != this._isSealed )
		{
			this._isSealed = isSealed;
			if ( !this._isSealed && this._cachedMethodCalls.length > 0 )
			{
				for ( cachedMethodCall in this._cachedMethodCalls )
				{
					cachedMethodCall();
				}
				
				this._cachedMethodCalls = [];
			}
		}
	}
}
