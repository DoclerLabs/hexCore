package hex.collection;

import hex.core.HashCodeFactory;
using hex.error.Error;

/**
 * ...
 * @author Francis Bourre
 */
class HashMap<K, V> implements IHashMap<K, V>
{

	var _keys			: Map<String, V>;
	var _values			: Map<String, K>;
	var _size			: Int;
	
	public function new( ?initial : Map<K, V> )
	{
		this._init();
		if ( initial != null ) for ( k in initial.keys() ) this.put( k, initial[ k ] );
	}
	
	function _init() : Void
	{
		this._keys 		= new Map<String, V>();
		this._values 	= new Map<String, K>();
		this._size 		= 0;
	}
	
	/**
	 * Removes all of the mappings from this map.
	 */
	public function clear() this._init();
	
	/**
	 * Returns <code>true</code> if this map contains a mapping for the specified
	 * key.  More formally, returns <code>true</code> if and only if
	 * this map contains a mapping for a key <code>k</code> such that
	 * <code>key === k</code>.  (There can be at most one such mapping.)
	 *
	 * @param   key      key object whose presence in this map is to be tested
	 * @return  <code>true</code> if this map contains a mapping for the specified
	 *          key
	 * @throws  <code>NullPointerException</code> —  if the specified key is null
	 */
	public function containsKey( key : K ) : Bool
	{
		if ( key != null ) 
		{
			return this._keys.exists( this._getName( key ) );
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
	}
	
	/**
	 * Returns <code>true</code> if this map maps one or more keys to the
	 * specified value.  More formally, returns <code>true</code> if and only if
	 * this map contains at least one mapping to a value <code>v</code> such that
	 * <code>(value === v)</code>.
	 * 
	 * @param   value   value whose presence in this map is to be tested
	 * @return <code>true</code> if this map maps one or more keys to the
	 *         specified value
	 * @throws  <code>NullPointerException</code> —  if the specified value is null
	 */
	public function containsValue( value : V ) : Bool
	{
		if ( value != null ) 
		{
			return this._values.exists( this._getName( value ) );
		}
		else
		{
			throw new NullPointerException( "Value can't be null" );
		}
	}
	
	/**
	 * Returns the value to which the specified key is mapped,
	 * or <code>null</code> if this map contains no mapping for the key.
	 * <p>
	 * More formally, if this map contains a mapping from a key
	 * <code>k</code> to a value <code>v</code> such that 
	 * <code>(key === k)</code>, then this method returns <code>v</code>; otherwise
	 * it returns <code>null</code>.  (There can be at most one such mapping.)
	 * </p><p>
	 * As this map permits null values, a return value of <code>null</code>
	 * does not <i>necessarily</i> indicate that the map contains no mapping
	 * for the key; it's also possible that the map explicitly maps the key to
	 * <code>null</code>. The <code>containsKey</code> operation may be used
	 * to distinguish these two cases.
	 * </p>
	 * @param   key     the key whose associated value is to be returned
	 * @return  the value to which the specified key is mapped, or
	 *          <code>null</code> if this map contains no mapping for the key
	 * @throws  <code>NullPointerException</code> —  if the specified key is null
	 */
	public function get( key : K ) : V
	{
		if ( key != null )
		{
			return this._keys.get( this._getName( key ) );
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
	}
	
	/**
	 * @return <code>true</code> if this map contains no key-value mappings
	 */
	public function isEmpty() return ( this._size == 0 );
	
	/**
	 * Associates the specified value with the specified key in this map
	 * (optional operation).  If the map previously contained a mapping for
	 * the key, the old value is replaced by the specified value.  (A map
	 * <code>m</code> is said to contain a mapping for a key <code>k</code> 
	 * if and only if <code>m.containsKey(k)</code> would return
	 * <code>true</code>.)
	 *
	 * @param   key     key with which the specified value is to be associated
	 * @param   value   value to be associated with the specified key
	 * @return  the previous value associated with <code>key</code>, or
	 *          <code>null</code> if there was no mapping for <code>key</code>.
	 *          (A <code>null</code> return can also indicate that the map
	 *          previously associated <code>null</code> with <code>key</code>,
	 *          if the implementation supports <code>null</code> values.)
	 * @throws  <code>NullPointerException</code> —  if the specified key or value is null
	 */
	public function put( key : K, value : V ) : V
	{
		var oldValue : V = null;
		
		if ( key == null )
		{
			throw new NullPointerException( "Key can't be null" );
		} 
		else if ( value == null )
		{
			throw new NullPointerException( "Value can't be null" );
		}
		else
		{
			if ( this.containsKey( key ) ) 
			{
				oldValue = this.remove( key );
			}
			
			this._size++;
			this._keys.set( this._getName( key ), value );
			this._values.set( this._getName( value ), key );
			return oldValue;
		}
	}
	
	function _getName( o : Dynamic ) : String
	{
		var s : String;
		
		if ( Std.is( o, String ) ) 
		{
			s = '_S' + o;
		}
		else if ( Std.is( o, Bool ) )
		{
			s = '_B' + o;
		}
		else if ( Std.is( o, Float ) )
		{
			s = '_N' + o;
		}
		else 
		{
			s = '_O' + HashCodeFactory.getKey( o );
		}
		
		return s;
	}
	
	/**
	 * Removes the mapping for a key from this map if it is present
	 * (optional operation). More formally, if this map contains a mapping
	 * from key <code>k</code> to value <code>v</code> such that
	 * <code>(key === k)</code>, that mapping is removed. 
	 * (The map can contain at most one such mapping.)
	 * <p>
	 * Returns the value to which this map previously associated the key,
	 * or <code>null</code> if the map contained no mapping for the key.
	 * </p><p>
	 * As this map permits null values, then a return value of
	 * <code>null</code> does not <i>necessarily</i> indicate that the map
	 * contained no mapping for the key; it's also possible that the map
	 * explicitly mapped the key to <code>null</code>.
	 * </p><p>
	 * The map will not contain a mapping for the specified key once the
	 * call returns.
	 * </p>
	 * @param   key             key whose mapping is to be removed from the map
	 * @return  the previous value associated with <code>key</code>, or
	 *          <code>null</code> if there was no mapping for <code>key</code>.
	 * @throws  <code>NullPointerException</code> —  if the specified key is null 
	 */
	public function remove( key : K ) : V
	{
		if ( key != null )
		{
			var sKID : String = this._getName( key );
		
			if ( this._keys.exists( sKID ) )
			{
				var sVID : String = this._getName( this._keys[ sKID ] );
				var value : V = this._keys.get( sKID );
				this._values.remove( sVID );
				this._keys.remove( sKID );
				this._size--;
				return value;
			}
			else
			{
				return null;
			}
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
	}
	
	/**
	 * @return the number of key-value mappings in this map
	 */
	public function size() return this._size;

	/**
	 * @return an array view of the keys contained in this map
	 */
	public function getKeys() : Array<K>
	{
		var a = new Array<K>();
		var it = this._values.iterator();
		while ( it.hasNext() )
		{
			a.push( it.next() );
		}
		return a;
	}
	
	/**
	 * @return an array view of the values contained in this map
	 */
	public function getValues() : Array<V>
	{
		var a = new Array<V>();
		var it = this._keys.iterator();
		while ( it.hasNext() )
		{
			a.push( it.next() );
		}
		return a;
	}
}