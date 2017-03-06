package hex.collection;

import hex.error.IllegalArgumentException;
import hex.error.NoSuchElementException;
import hex.event.ITrigger;
import hex.event.ITriggerOwner;
import hex.util.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Locator<KeyType, ValueType> 
	implements ITriggerOwner
	implements ILocator<KeyType, ValueType>
{
	public var trigger ( default, never ) : ITrigger<ILocatorListener<Dynamic, Dynamic>>;
	
    var _map    		: HashMap<KeyType, ValueType>;

    public function new()
    {
        this._map = new HashMap();
    }
	
	public function clear() : Void
	{
		this._map.clear();
	}
	
	public function release() : Void
	{
		this.clear();
		#if !macro
		this.trigger.disconnectAll();
		#end
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
			#if !macro
            this._dispatchRegisterEvent( key, element );
			#end
            return true;
        }
    }

    public function unregister( key : KeyType ) : Bool
    {
        if ( this.isRegisteredWithKey( key ) )
        {
            this._map.remove( key );
			#if !macro
            this._dispatchUnregisterEvent( key );
			#end
            return true;
        }
        else
        {
            return false;
        }
    }

    public function addListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
		return this.trigger.connect( listener );
    }

    public function removeListener( listener : ILocatorListener<KeyType, ValueType> ) : Bool
    {
		return this.trigger.disconnect( listener );
    }

    public function toString() : String
    {
        return Stringifier.stringify( this );
    }

    function _dispatchRegisterEvent( key : KeyType, element : ValueType ) : Void
    {
		#if !macro
		this.trigger.onRegister( key, element );
		#else
		haxe.macro.Context.error( "Dispatch cannot be used at compile time.", haxe.macro.Context.currentPos() );
		#end
    }

    function  _dispatchUnregisterEvent( key : KeyType ) : Void
    {
		#if !macro
		this.trigger.onUnregister( key );
		#else
		haxe.macro.Context.error( "Dispatch cannot be used at compile time.", haxe.macro.Context.currentPos() );
		#end
    }
}