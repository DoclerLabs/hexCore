package hex.collection;

import hex.error.IllegalArgumentException;
import hex.error.NoSuchElementException;
import hex.event.Dispatcher;
import hex.event.IDispatcher;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Locator<KeyType:Dynamic, ValueType> implements ILocator<KeyType, ValueType>
{
    var _dispatcher     : IDispatcher<ILocatorListener<KeyType, ValueType>>;
    var _map    		: HashMap<KeyType, ValueType>;

    public function new()
    {
        this._map   		= new HashMap();
        this._dispatcher    = new Dispatcher<ILocatorListener<KeyType, ValueType>>();
    }
	
	public function clear() : Void
	{
		this._map.clear();
	}
	
	public function release() : Void
	{
		this.clear();
		this._dispatcher.removeAllListeners();
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
            this._dispatchRegisterEvent( key, element );
            return true;
        }
    }

    public function unregister( key : KeyType ) : Bool
    {
        if ( this.isRegisteredWithKey( key ) )
        {
            this._map.remove( key );
            this._dispatchUnregisterEvent( key );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function addListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
        return this._dispatcher.addListener( listener );
    }

    public function removeListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
        return this._dispatcher.removeListener( listener );
    }

    public function toString() : String
    {
        return Stringifier.stringify( this );
    }

    function _dispatchRegisterEvent( key : KeyType, element : ValueType ) : Void
    {
		
    }

    function  _dispatchUnregisterEvent( key : KeyType ) : Void
    {
		
    }
}