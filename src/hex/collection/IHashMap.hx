package hex.collection;

/**
 * @author Francis Bourre
 */
interface IHashMap<K, V> 
{
	function clear() : Void;
	function containsKey( key : K ) : Bool;
	function containsValue( value : V ) : Bool;
	function get( key : K ) : V;
	function isEmpty() : Bool;
	function put( key : K, value : V ) : V;
	function remove( key : K ) : V;
	function size() : Int;
	function getKeys() : Array<K>;
	function getValues() : Array<V>;
}