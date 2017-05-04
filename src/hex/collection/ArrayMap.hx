package hex.collection;

import hex.collection.IHashMap;
import hex.error.NullPointerException;
import hex.util.ArrayUtil;

/**
 * ...
 * @author Francis Bourre
 */
class ArrayMap<K, V> implements IHashMap<K, V>
{
	var _k : Array<K>;
	var _v : Array<V>;
	
	public function new() 
	{
		this._k = [];
		this._v = [];
	}
	
	public function clear() : Void 
	{
		this._k = [];
		this._v = [];
	}
	
	public function containsKey( key : K ) : Bool 
	{
		if ( key != null ) 
		{
			return ArrayUtil.indexOf( this._k, key ) != -1;
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
	}
	
	public function containsValue( value : V ) : Bool 
	{
		if ( value != null ) 
		{
			return ArrayUtil.indexOf( this._v, value ) != -1;
		}
		else
		{
			throw new NullPointerException( "Value can't be null" );
		}
	}
	
	public function get( key : K ) : V 
	{
		if ( key != null )
		{
			return this._v[ ArrayUtil.indexOf( this._k, key ) ];
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
	}
	
	public function isEmpty() : Bool 
	{
		return this._k.length == 0;
	}
	
	public function put( key : K, value : V ) : V 
	{
		var oldValue = null;
		
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
			switch ArrayUtil.indexOf( this._k, key )
			{
				case -1: 
					this._k.push( key ); 
					this._v.push( value );
					
				case i: 
					oldValue = this._v[ i ];
					this._v[ i ] = value;
			}
		}
		
		return oldValue;
	}
	
	public function remove( key : K ) : V 
	{
		var oldValue = null;
		
		if ( key != null )
		{
			switch ArrayUtil.indexOf( this._k, key )
			{
				case -1: 
					return null;
					
				case last if ( last == this._k.length - 1 ):
					this._k.pop();
					return this._v.pop();
				true;
				
			case v:
					oldValue = this._v[ v ];
					this._k[ v ] = this._k.pop(); 
					this._v[ v ] = this._v.pop(); 
					true;
			}
		}
		else
		{
			throw new NullPointerException( "Key can't be null" );
		}
		
		return oldValue;
	}
	
	public function size() : Int 
	{
		return this._k.length;
	}
	
	public function getKeys() : Array<K> 
	{
		return this._k.copy();
	}
	
	public function getValues() : Array<V> 
	{
		return this._v.copy();
	}
	
	public function clone() : IHashMap<K, V>
	{
		var m = new ArrayMap();
		m._k = this._k.copy();
		m._v = this._v.copy();
		return m;
	}
}