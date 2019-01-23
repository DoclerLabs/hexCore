package hex.di;

abstract ClassName( String ) 
{
	inline function new( s ) this = s;
	
	@:to inline function toString() : String return this;
 	
	@:to function toClass()
		return Type.resolveClass( this.split( '<' )[ 0 ] );
	
	@:from static inline function ofString( s : String ) : ClassName
		return new ClassName( s );
		
	@:from static function ofClassRef<T>( c : ClassRef<T> ) : ClassName
		return Type.getClassName( c );
  
}