package hex.event;

import hex.error.UnsupportedOperationException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Dispatcher<ListenerType:Dynamic> implements IDispatcher<ListenerType>
{
	private var _isSealed 			: Bool;
	private var _cachedMethodCalls 	: Array<Dynamic>;
    private var _listeners 			: Array<ListenerType>;
    private var _closures 			: Map<MessageType, Array<Dynamic>>;
    private var _callbacks 			: Map<MessageType, Array<Dynamic>>;
    private var _closureSize 		: UInt;

    public function new()
    {
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
        this._listeners 			= [];
		this._closures         		= new Map();
		this._callbacks         	= new Map();
        this._closureSize      		= 0;
    }
	
	public function dispatch( messageType : MessageType, data : Array<Dynamic> ) : Void
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
	}
	
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