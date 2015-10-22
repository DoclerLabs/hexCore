package hex.collection;

import hex.log.Stringifier;
import hex.error.IllegalArgumentException;
import hex.error.NoSuchElementException;
import hex.event.IEventDispatcher;
import hex.event.EventDispatcher;

class BaseLocator<KeyType:Dynamic, ValueType> implements ILocator<KeyType, ValueType>
{
    private var _ed     : IEventDispatcher<ILocatorListener<KeyType, ValueType>, LocatorEvent<KeyType, ValueType>>;
    private var _map    : Map<KeyType, ValueType>;

    public function new()
    {
        this._map   = new Map<KeyType, ValueType>();
        this._ed    = new EventDispatcher<ILocatorListener<KeyType, ValueType>, LocatorEvent<KeyType, ValueType>>();
    }

    public function keys() : Iterator<KeyType>
    {
        return this._map.keys();
    }

    public function values() : Iterator<ValueType>
    {
        return this._map.iterator();
    }

    public function isRegisteredWithKey( key : KeyType ) : Bool
    {
        return this._map.exists( key );
    }

    public function locate( key : KeyType ) : ValueType
    {
        if ( this.isRegisteredWithKey( key ) )
        {
            return this._map.get( key );
        }
        else
        {
            throw new NoSuchElementException( "Can't find item with '" + key + "' key in " + this.toString() );
        }
    }

    public function add( m : Map<KeyType, ValueType> ) : Void
    {
        var iterator = m.keys();

        while( iterator.hasNext() )
        {
            var key : KeyType = iterator.next();
            this.register( key, m.get( key ) );
        }
    }

    public function register( key : KeyType, element : ValueType ) : Bool
    {
        if ( this._map.exists( key ) )
        {
            throw new IllegalArgumentException( "item is already registered with '" + key + "' key in " + this.toString() );
        }
        else
        {
            this._map.set( key, element );
            this.onRegister( key, element );
            return true;
        }
    }

    public function unregister( key : KeyType ) : Bool
    {
        if ( this.isRegisteredWithKey( key ) )
        {
            this._map.remove( key );
            this.onUnregister( key );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function addListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
        return this._ed.addListener( listener );
    }

    public function removeListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
        return this._ed.removeListener( listener );
    }

    public function toString() : String
    {
        return Stringifier.stringify( this );
    }

    private function onRegister( key : KeyType, element : ValueType ) : Void
    {
        this._ed.dispatchEvent( new LocatorEvent( LocatorEvent.REGISTER, this, key, element ) );
    }

    private function  onUnregister( key : KeyType ) : Void
    {
        this._ed.dispatchEvent( new LocatorEvent( LocatorEvent.UNREGISTER, this, key ) );
    }
}