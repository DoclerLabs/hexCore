package hex;

import hex.di.IDependencyInjector;
import hex.di.IInjectorListener;
import hex.di.provider.IDependencyProvider;

/**
 * ...
 * @author Francis Bourre
 */
class MockDependencyInjector implements IDependencyInjector
{
	public function new() 
	{
		
	}
	
	public function hasMapping( type : Class<Dynamic>, name : String = '' ) : Bool 
	{
		return false;
	}
	
	public function hasDirectMapping( type : Class<Dynamic>, name:String = '' ) : Bool 
	{
		return false;
	}
	
	public function satisfies( type : Class<Dynamic>, name : String = '' ) : Bool 
	{
		return false;
	}
	
	public function injectInto( target : Dynamic ) : Void 
	{
		
	}
	
	public function getInstance<T>( type : Class<T>, name : String = '' ) : T 
	{
		return null;
	}
	
	public function getInstanceWithClassName<T>( className : String, name : String = '' ) : T
	{
		return null;
	}
	
	public function getOrCreateNewInstance<T>( type : Class<Dynamic> ) : T 
	{
		return Type.createInstance( type, [] );
	}
	
	public function instantiateUnmapped<T>( type : Class<Dynamic> ) : T 
	{
		return Type.createInstance( type, [] );
	}
	
	public function destroyInstance( instance : Dynamic ) : Void 
	{
		
	}
	
	public function mapToValue( clazz : Class<Dynamic>, value : Dynamic, ?name : String = '' ) : Void 
	{
		
	}
	
	public function mapToType( clazz : Class<Dynamic>, type : Class<Dynamic>, name : String = '' ) : Void 
	{
		
	}
	
	public function mapToSingleton( clazz : Class<Dynamic>, type : Class<Dynamic>, name : String = '' ) : Void 
	{
		
	}
	
	public function unmap( type : Class<Dynamic>, name : String = '' ) : Void 
	{
		
	}

	public function addListener( listener : IInjectorListener ) : Bool
	{
		return false;
	}

	public function removeListener( listener : IInjectorListener ) : Bool
	{
		return false;
	}
	
	public function getProvider( className : String, name : String = '' ) : IDependencyProvider
	{
		return null;
	}
	
	public function mapClassNameToValue( className : String, value : Dynamic, ?name : String = '' ) : Void
	{
		
	}

    public function mapClassNameToType( className : String, type : Class<Dynamic>, name:String = '' ) : Void
	{
		
	}

    public function mapClassNameToSingleton( className : String, type : Class<Dynamic>, name:String = '' ) : Void
	{
		
	}
	
	public function unmapClassName( className : String, name : String = '' ) : Void
	{
		
	}
}