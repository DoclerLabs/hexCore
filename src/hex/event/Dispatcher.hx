package hex.event;

import hex.error.IllegalArgumentException;
import hex.error.UnsupportedOperationException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Dispatcher<ListenerType:{}> implements IDispatcher<ListenerType>
{
	/*private var _isSealed 			: Bool;
	private var _cachedMethodCalls 	: Array<Dynamic>;
    private var _listeners 			: Array<ListenerType>;
    private var _closures 			: Map<MessageType, Array<Dynamic>>;
    private var _callbacks 			: Map<MessageType, Array<Dynamic>>;
    private var _closureSize 		: UInt;*/
	
	private var _isSealed 			: Bool;
	private var _cachedMethodCalls 	: Array<Void->Void>;
    private var _listeners 			: Map<ListenerType, Map<MessageType, Dynamic>>;

    /*public function new()
    {
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
        this._listeners 			= [];
		this._closures         		= new Map();
		this._callbacks         	= new Map();
        this._closureSize      		= 0;
    }*/
	
	public function new()
    {
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
        this._listeners 			= new Map();
    }
	
	/*public function dispatch( messageType : MessageType, data : Array<Dynamic> ) : Void
	{
		this._seal( true );
		
		var listeners = this._listeners.copy();

        for ( listener in listeners )
        {
			var callback = Reflect.field( listener, messageType.messageName );
            if ( callback != null )
            {
				Reflect.callMethod ( listener, callback, data );
            }
			else
			{
				var msg : String = Stringifier.stringify( this ) + ".dispatch failed. " +
				" You must implement 'handleMessage' method in '" +
				Stringifier.stringify( listener ) + "' instance.";
				throw( new UnsupportedOperationException( msg ) );
			}
        }
		
		if ( this._closures.exists( messageType ) )
        {
			var callbacks = this._callbacks.get( messageType ).copy();
            for ( f in callbacks )
            {
                f( data );
            }
        }
		
		this._seal( false );
	}*/
	
	public function dispatch( messageType : MessageType, data : Array<Dynamic> ) : Void
    {
		this._seal( true );
		
        var iterator = this._listeners.keys();
        while ( iterator.hasNext() )
        {
            var listener : ListenerType 	= iterator.next();
            var m : Map<MessageType, Dynamic> 	= this._listeners.get( listener );
			
            if ( Lambda.count( m ) > 0 )
            {
				if ( m.exists( messageType ) )
				{
					m.get( messageType )( data );
				}
            }
            else
            {
                var callback = Reflect.field( listener, messageType.name );
                if ( callback != null )
                {
                    Reflect.callMethod ( listener, callback, data );
                }
                else
                {
					var msg : String = Stringifier.stringify( this ) + ".dispatch failed. " +
					" You must implement 'handleMessage' method in '" +
					Stringifier.stringify( listener ) + "' instance.";
					throw( new UnsupportedOperationException( msg ) );
                }
            }
        }

		this._seal( false );
    }
	
	/*
	public function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool
	{
		if ( !this._isSealed )
		{
			if ( !this._closures.exists( messageType ) )
			{
				this._closures.set( messageType, [] );
				this._callbacks.set( messageType, [] );
			}

			var callbacks : Array<Dynamic> = this._closures.get( messageType );
			var index : Int = callbacks.indexOf( callback );
			if ( index == -1 )
			{
				callbacks.push( callback );
				
				var f = function ( args : Array<Dynamic> ) : Void
				{
					Reflect.callMethod( scope, callback, args );
				}
				this._callbacks.get( messageType ).push( f );
				
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
			this._cachedMethodCalls.push( this.addHandler.bind( messageType, callback ) );
			return false;
		}
	}
	*/
	
	public function addHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( scope ) )
			{
				var m : Map<MessageType, Dynamic> = this._listeners.get( scope );

				if ( Lambda.count( m ) == 0 )
				{
					var msg : String = Stringifier.stringify( this ) + ".addHandler failed. " +
					Stringifier.stringify( scope ) + " is already registered for all message types.";
					throw ( new IllegalArgumentException( msg ) );
				}
				else if ( m.exists( messageType ) )
				{
					return false;
				}
				else
				{
					var f = function ( args : Array<Dynamic> ) : Void
					{
						Reflect.callMethod( scope, callback, args );
					}
					m.set( messageType, f );
					return true;
				}
			}
			else
			{
				var m : Map<MessageType, Dynamic> = new Map();
				var f = function ( args : Array<Dynamic> ) : Void
				{
					Reflect.callMethod( scope, callback, args );
				}
				m.set( messageType, f );
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
	
	/*
	public function removeHandler( messageType : MessageType, callback : Dynamic ) : Bool
	{
		if ( !this._isSealed )
		{
			if ( !this._closures.exists( messageType ) )
			{
				return false;
			}
		
			var callbacks : Array<Dynamic> = this._closures.get( messageType );
			var index : Int = callbacks.indexOf( callback );
			if ( index == -1 )
			{
				return false;
			}
			else
			{
				callbacks.splice( index, 1 );
				this._callbacks.get( messageType ).splice( index, 1 );
				this._closureSize--;

				if ( callbacks.length == 0 )
				{
					this._closures.remove( messageType );
				}

				return true;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.removeHandler.bind( messageType, callback ) );
			return false;
		}
	}
	*/
	
	public function removeHandler( messageType : MessageType, scope : Dynamic, callback : Dynamic ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( scope ) )
			{
				var m : Map<MessageType, Dynamic> = this._listeners.get( scope );

				if ( Lambda.count( m ) == 0 )
				{
					var msg : String = Stringifier.stringify( this ) + ".removeHandler failed. " +
					Stringifier.stringify( scope ) + " is registered for all message types." +
					" Use 'removeListener' to unsubscribe.";
					throw ( new IllegalArgumentException( msg ) );
				}
				else if ( m.exists( messageType ) )
				{
					m.remove( messageType );
					if ( Lambda.count( m ) == 0 )
					{
						this._listeners.remove( scope );
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
		else
		{
			this._cachedMethodCalls.push( this.removeHandler.bind( messageType, scope, callback ) );
			return false;
		}
    }
	
	/*
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
	*/
	
	public function addListener( listener : ListenerType ) : Bool
    {
		if ( !this._isSealed )
		{
			if ( this._listeners.exists( listener ) )
			{
				var m : Map<MessageType, Dynamic> = this._listeners.get( listener );
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
				this._listeners.set( listener, new Map<MessageType, Dynamic>() );
				return true;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.addListener.bind( listener ) );
			return false;
		}
    }
	
	/*
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
	*/
	
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

	/*
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
	*/
	
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
	
	/*
	public function isEmpty() : Bool
    {
		return this._listeners.length == 0 && this._closureSize == 0;
    }
	*/
	
	public function isEmpty() : Bool
    {
        return Lambda.count( this._listeners ) == 0;
    }
	
	public function isRegistered( listener : ListenerType, ?messageType : MessageType ) : Bool
	{
		//var messageName : String = messageType.messageName;
		
        if ( this._listeners.exists( listener ) )
        {
            if ( messageType == null )
            {
                return true;
            }
            else
            {
			var m : Map<MessageType, Dynamic> = this._listeners.get( listener );
                return m.exists( messageType );
            }
        }
        else
        {
            return false;
        }
    }

    public function hasHandler( messageType : MessageType, ?scope : Dynamic, ?callback : Dynamic  ) : Bool
    {
        if ( callback == null )
        {
            var iterator = this._listeners.keys();
            while ( iterator.hasNext() )
            {
                var listener : ListenerType = iterator.next();
				var m : Map<MessageType, Dynamic> = this._listeners.get( listener );
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
                return true;
            }
            else
            {
                return false;
            }
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