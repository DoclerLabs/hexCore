package hex.collection;

import hex.log.Stringifier;
import hex.error.IllegalArgumentException;
import hex.error.NoSuchElementException;
import hex.event.IEventDispatcher;
import hex.event.EventDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class Locator<KeyType:Dynamic, ValueType> implements ILocator<KeyType, ValueType>
{
    private var _ed     : IEventDispatcher<ILocatorListener<KeyType, ValueType>, LocatorEvent<KeyType, ValueType>>;
    private var _map    : HashMap<KeyType, ValueType>;

    public function new()
    {
        this._map   = new HashMap<KeyType, ValueType>();
        this._ed    = new EventDispatcher<ILocatorListener<KeyType, ValueType>, LocatorEvent<KeyType, ValueType>>();
    }
	
	public function clear() : Void
	{
		this._map.clear();
	}
	
	public function release() : Void
	{
		this.clear();
		this._map = null;

		if ( this._ed != null )
		{
			this._ed.removeAllListeners();
			this._ed = null;
		}
	}
	
	public function isEmpty() : Bool
	{
		return this._map.size() == 0;
	}

    public function keys() : Array<KeyType>
    {
        return this._map.getKeys();
    }
	
    public function values() : Array<ValueType>
    {
        return this._map.getValues();
    }

    public function isRegisteredWithKey( key : KeyType ) : Bool
    {
        return this._map.containsKey( key );
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
        if ( this._map.containsKey( key ) )
        {
            throw new IllegalArgumentException( "item is already registered with '" + key + "' key in " + this.toString() );
        }
        else
        {
            this._map.put( key, element );
            this._onRegister( key, element );
            return true;
        }
    }

    public function unregister( key : KeyType ) : Bool
    {
        if ( this.isRegisteredWithKey( key ) )
        {
            this._map.remove( key );
            this._onUnregister( key );
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

    private function _onRegister( key : KeyType, element : ValueType ) : Void
    {
        this._ed.dispatchEvent( new LocatorEvent( LocatorEvent.REGISTER, this, key, element ) );
    }

    private function  _onUnregister( key : KeyType ) : Void
    {
        this._ed.dispatchEvent( new LocatorEvent( LocatorEvent.UNREGISTER, this, key ) );
    }
}