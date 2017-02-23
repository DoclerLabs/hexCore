package hex.event;

import hex.error.IllegalArgumentException;
import hex.error.UnsupportedOperationException;
import hex.util.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Dispatcher<ListenerType:{}> implements IDispatcher<ListenerType>
{
	var _isSealed 			: Bool;
	var _cachedMethodCalls 	: Array<Void->Void>;
    var _listeners 			: Map<ListenerType, Map<String, CallbackHandler>>;

	public function new()
    {
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
        this._listeners 			= new Map();
    }
	
	public function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void
    {
		this._seal( true );
		
		var parameters : Array<Dynamic> = null;
		
        var iterator = this._listeners.keys();
        while ( iterator.hasNext() )
        {
            var listener : ListenerType 	= iterator.next();
            var m : Map<String, CallbackHandler> 	= this._listeners.get( listener );
			
            if ( Lambda.count( m ) > 0 )
            {
				if ( m.exists( messageType ) )
				{
					var handler : CallbackHandler = m.get( messageType );
					handler.call( data );
				}
            }
            else
            {
				var messageName : String = messageType;
                var callback = Reflect.field( listener, messageName );
                if ( callback != null && messageName != 'handleMessage' )
                {
					Reflect.callMethod ( listener, callback, data );
                }
                else
                {
					callback = Reflect.field( listener, 'handleMessage' );
					
					if ( callback != null )
					{
						if ( parameters == null )
						{
							parameters = [messageType];
							if ( data != null )
							{
								parameters = parameters.concat( data );
							}
							}
						
						Reflect.callMethod ( listener, callback, parameters );
						
					} else
					{
						var msg : String = Stringifier.stringify( this ) + ".dispatch failed. " +
						" You must implement '" + messageType + "' or 'handleMessage' method in '" +
						Stringifier.stringify( listener ) + "' instance.";
						throw( new UnsupportedOperationException( msg ) );
					}
                }
            }
        }

		this._seal( false );
    }
	
	public function addHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( scope ) )
			{
				var m : Map<String, Dynamic> = this._listeners.get( scope );

				if ( Lambda.count( m ) == 0 )
				{
					var msg : String = Stringifier.stringify( this ) + ".addHandler failed. " +
					Stringifier.stringify( scope ) + " is already registered for all message types.";
					throw ( new IllegalArgumentException( msg ) );
				}
				else if ( m.exists( messageType ) )
				{
					var handler : CallbackHandler = m.get( messageType );
					return handler.add( callback );
				}
				else
				{
					var handler = new CallbackHandler( scope, callback );
					m.set( messageType, handler );
					return true;
				}
			}
			else
			{
				var m = new Map<String, CallbackHandler>();
				var handler = new CallbackHandler( scope, callback );
				m.set( messageType, handler );
				this._listeners.set( scope, m );
				
				return true;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.addHandler.bind( messageType, scope, callback ) );
			return false;
		}
    }
	
	public function removeHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( scope ) )
			{
				var m : Map<String, CallbackHandler> = this._listeners.get( scope );

				if ( Lambda.count( m ) == 0 )
				{
					var msg : String = Stringifier.stringify( this ) + ".removeHandler failed. " +
					Stringifier.stringify( scope ) + " is registered for all message types." +
					" Use 'removeListener' to unsubscribe.";
					throw ( new IllegalArgumentException( msg ) );
				}
				else if ( m.exists( messageType ) )
				{
					var handler : CallbackHandler = m.get( messageType );
					var b : Bool = handler.remove( callback );
					
					if ( handler.isEmpty() )
					{
						m.remove( messageType );
						if ( Lambda.count( m ) == 0 )
						{
							this._listeners.remove( scope );
						}
					}
					
					return b;
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
		else
		{
			this._cachedMethodCalls.push( this.removeHandler.bind( messageType, scope, callback ) );
			return false;
		}
    }
	
	public function addListener( listener : ListenerType ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( listener ) )
			{
				var m : Map<String, CallbackHandler> = this._listeners.get( listener );
				if ( Lambda.count( m ) > 0 )
				{
					var msg : String = Stringifier.stringify( this ) + ".addListener failed. " +
					Stringifier.stringify( listener ) + " is already registered to ";
					var iterator = m.keys();
					while ( iterator.hasNext() )
					{
						msg += "'" + iterator.next() + "' ";
					}
					msg += "message types.";

					throw ( new IllegalArgumentException( msg ) );
				}
				else
				{
					return false;
				}
			}
			else
			{
				this._listeners.set( listener, new Map<String, CallbackHandler>() );
				return true;
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
			this._listeners = new Map();
		}
		else
		{
			this._cachedMethodCalls.push( this.removeAllListeners.bind() );
		}
    }

	public function isEmpty() : Bool
    {
        return Lambda.count( this._listeners ) == 0;
    }
	
	public function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool
	{
        if ( this._listeners.exists( listener ) )
        {
            if ( messageType == null )
            {
                return true;
            }
            else
            {
			var m : Map<String, CallbackHandler> = this._listeners.get( listener );
                return m.exists( messageType );
            }
        }
        else
        {
            return false;
        }
    }

    public function hasHandler( messageType : MessageType, ?scope : Dynamic ) : Bool
    {
        if ( scope == null )
        {
            var iterator = this._listeners.keys();
            while ( iterator.hasNext() )
            {
                var listener : ListenerType = iterator.next();
				var m : Map<String, CallbackHandler> = this._listeners.get( listener );
				if ( Lambda.count( m ) == 0 )
				{
					return true;
				}
				else if ( m.exists( messageType ) )
                {
                    return true;
                }
            }

            return false;
        }
        else
        {
            if ( this._listeners.exists( scope ) )
            {
				var m : Map<String, CallbackHandler> = this._listeners.get( scope );
				if ( Lambda.count( m ) == 0 )
				{
					return true;
				}
				else if ( m.exists( messageType ) )
                {
                    return true;
                }
				
				return false;
            }
            else
            {
                return false;
            }
        }
    }
	
	function _seal( isSealed : Bool ) : Void
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