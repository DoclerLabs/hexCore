package hex.di;

/**
 * ...
 * @author Francis Bourre
 */
abstract Dependency<T>( Dynamic ) 
{ 
	inline public function new( v: T ) this = v;
}