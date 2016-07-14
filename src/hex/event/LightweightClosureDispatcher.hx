package hex.event;

import hex.log.Stringifier;
import hex.error.UnsupportedOperationException;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightClosureDispatcher<EventType:IEvent> implements IEventDispatcher<IEventListener, EventType>
{
    var _callbacks      	: Map<String, Array<EventType->Void>>;
    var _callbackSize   	: UInt;

    public function new()
    {
        this._callbacks         	= new Map();
        this._callbackSize      	= 0;
    }

    public function dispatchEvent( e : EventType ) : Void
    {
        var eventType : String = e.type;
        if ( this._callbacks.exists( eventType ) )
        {
			var callbacks = this._callbacks.get( eventType ).copy();
            for ( f in callbacks )
            {
                f( e );
            }
        }
    }

    public function addEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        if ( !this._callbacks.exists( eventType ) )
        {
            this._callbacks.set( eventType, [] );
        }

        var callbacks : Array<EventType->Void> = this._callbacks.get( eventType );

		#if !neko
		var index : Int = callbacks.indexOf( callback );
        if ( index == -1 )
        {
            callbacks.push( callback );
            this._callbackSize++;
            return true;
        }
        else
        {
            return false;
        }
		#else
		for ( c in callbacks )
		{
			if ( Reflect.compareMethods( c, callback ) )
			{
				return false;
			}
		}
		
		callbacks.push( callback );
		this._callbackSize++;
		return true;
		#end
    }

    public function removeEventListener( eventType : String, callback : EventType->Void ) : Bool
    {
        if ( !this._callbacks.exists( eventType ) )
        {
            return false;
        }

		var callbacks : Array<EventType->Void> = this._callbacks.get( eventType );
		
		#if !neko
		var index : Int = callbacks.indexOf( callback );
        if ( index == -1 )
        {
            return false;
        }
        else
        {
            callbacks.splice( index, 1 );
            this._callbackSize--;

            if ( callbacks.length == 0 )
            {
                this._callbacks.remove( eventType );
            }

            return true;
        }
		#else
		var length = callbacks.length;
		for ( index in 0...length )
		{
			var method = callbacks[ index ];
			if ( Reflect.compareMethods( method, callback ) )
			{
				callbacks.splice( index, 1 );
				this._callbackSize--;

				if ( callbacks.length == 0 )
				{
					this._callbacks.remove( eventType );
				}

				return true;
			}
		}
	
		return false;
		#end
    }

    public function addListener( listener : {} ) : Bool
    {
        throw ( new UnsupportedOperationException( "'addListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }

    public function removeListener( listener : {} ) : Bool
    {
        throw ( new UnsupportedOperationException( "'removeListener' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }

    public function removeAllListeners() : Void
    {
        this._callbacks 		= new Map();
		this._callbackSize      = 0;
    }

    public function isEmpty() : Bool
    {
        return this._callbackSize == 0;
    }

    public function isRegistered( listener : {}, ?eventType : String ) : Bool
    {
        throw ( new UnsupportedOperationException( "'isRegistered' is not supported in '" + Stringifier.stringify( this ) + "'" ) );
    }

    public function hasEventListener( eventType : String, ?callback : EventType->Void  ) : Bool
    {
        if ( !this._callbacks.exists( eventType ) )
        {
            return false;
        }

        if ( callback == null )
        {
            return true;
        }
        else
        {
            #if !neko
            return this._callbacks.get( eventType ).indexOf( callback ) != -1;
			#else
			var closures = this._callbacks.get( eventType );
			for ( closure in closures )
			{
				if ( Reflect.compareMethods( closure, callback ) )
				{
					return true;
				}
			}
			
			return false;
			#end
        }
    }
}
