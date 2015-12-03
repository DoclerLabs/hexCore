package hex.event;

import hex.error.UnsupportedOperationException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class CompositeClosureDispatcher<EventType:IEvent> implements IEventDispatcher<IEventListener, EventType>
{
	private var _dispatchers 		: Array<IEventDispatcher<IEventListener, EventType>>;
	private var _isSealed 			: Bool;
	private var _cachedMethodCalls 	: Array<Void->Void>;
	
	public function new() 
	{
		this._isSealed 				= false;
		this._cachedMethodCalls 	= [];
		this._dispatchers 			= [];
	}
	
	public function dispatchEvent( event : EventType ) : Void 
	{
		this._seal( true );
		
		for ( dispatcher in this._dispatchers )
		{
			dispatcher.dispatchEvent( event );
		}
		
		this._seal( false );
	}
	
	public function addEventListener( eventType : String, callback : EventType->Void ) : Bool 
	{
		if ( !this._isSealed )
		{
			var b : Bool = true;
			for ( dispatcher in this._dispatchers )
			{
				b = dispatcher.addEventListener( eventType, callback ) && b;
			}

			return b;
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
			var b : Bool = true;
			for ( dispatcher in this._dispatchers )
			{
				b = dispatcher.removeEventListener( eventType, callback ) && b;
			}
			
			return b;
		}
		else
		{
			this._cachedMethodCalls.push( this.removeEventListener.bind( eventType, callback ) );
			return false;
		}
	}
	
	public function addListener( listener : IEventListener ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'addListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
	}
	
	public function removeListener( listener : IEventListener ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'removeListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
	}
	
	public function removeAllListeners() : Void 
	{
		if ( !this._isSealed )
		{
			for ( dispatcher in this._dispatchers )
			{
				dispatcher.removeAllListeners();
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.removeAllListeners.bind() );
		}
	}
	
	public function isEmpty() : Bool 
	{
		var b : Bool = true;
		for ( dispatcher in this._dispatchers )
		{
			b = dispatcher.isEmpty() && b;
		}
		return b;
	}
	
	public function isRegistered( listener : IEventListener, ?eventType : String ) : Bool 
	{
		throw ( new UnsupportedOperationException( "'isRegistered' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
	}
	
	public function hasEventListener( eventType : String, ?callback : EventType->Void ) : Bool 
	{
		var b : Bool = true;
		for ( dispatcher in this._dispatchers )
		{
			b = dispatcher.hasEventListener( eventType, callback ) && b;
		}
		return b;
	}
	
	public function add( dispatcher : IEventDispatcher<IEventListener, EventType> ) : Bool
	{
		if ( !this._isSealed )
		{
			if ( this._dispatchers.indexOf( dispatcher ) == -1 )
			{
				this._dispatchers.push( dispatcher );
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.add.bind( dispatcher ) );
			return false;
		}
	}
	
	public function remove( dispatcher : IEventDispatcher<IEventListener, EventType> ) : Bool
	{
		if ( !this._isSealed )
		{
			var index : Int = this._dispatchers.indexOf( dispatcher );
			if ( index != -1 )
			{
				this._dispatchers.splice( index, 1 );
				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			this._cachedMethodCalls.push( this.remove.bind( dispatcher ) );
			return false;
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