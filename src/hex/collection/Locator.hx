package hex.collection;

/**
 * ...
 * @author Francis Bourre
 */
class Locator<KeyType, ValueType> 
	implements hex.event.ITriggerOwner
	implements ILocator<KeyType, ValueType>
{
	public var trigger ( default, never ) : hex.event.ITrigger<ILocatorListener<Dynamic, Dynamic>>;
	
    var _map    		: ArrayMap<KeyType, ValueType> = new ArrayMap();

    public function new(){}
	
	public function clear() this._map.clear();
	
	public function release() : Void
	{
		this.clear();
		#if !macro
		this.trigger.disconnectAll();
		#end
	}
	
	public function isEmpty() return this._map.size() == 0;

    public function keys() return this._map.getKeys();
	
    public function values() return this._map.getValues();

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
            throw new hex.error.NoSuchElementException( "Can't find item with '" + key + "' key" );
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
            throw new hex.error.IllegalArgumentException( "item is already registered with '" + key + "' key" );
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