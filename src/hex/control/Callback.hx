package hex.control;

/**
 * ...
 * @author back2dos
 */
abstract Callback<T>( T->Void ) from ( T->Void )
{
	inline function new(f) 
    this = f;
	
    @:from static function fromNiladic<A>( f : Void->Void ) : Callback<A> //inlining this seems to cause recursive implicit casts
		return new Callback( function ( r ) f() );
	
	public inline function invoke( data : T ) : Void //TODO: consider swallowing null here
		( this )( data );
	
	@:to inline function toFunction()
		return this;
	
	@:from static function fromMany<A>( callbacks : Array<Callback<A>> ) : Callback<A> 
		return
		  function ( v : A ) 
			for ( callback in callbacks )
			  callback.invoke( v );
}