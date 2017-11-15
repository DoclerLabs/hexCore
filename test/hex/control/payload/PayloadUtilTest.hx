package hex.control.payload;

import hex.control.payload.ExecutionPayload;
import hex.control.payload.PayloadUtil;
import hex.di.IDependencyInjector;
import hex.di.IInjectorListener;
import hex.di.provider.IDependencyProvider;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class PayloadUtilTest
{
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( PayloadUtil );
	}
	
	@Test( "Test mapping" )
    public function testMapping() : Void
    {
		var injector 					= new MockDependencyInjectorForMapping();
		
		var mockImplementation 			= new MockImplementation( "mockImplementation" );
		var anotherMockImplementation 	= new MockImplementation( "anotherMockImplementation" );
		
		var mockPayload 				= new ExecutionPayload( mockImplementation, IMockType, "mockPayload" );
		var stringPayload 				= new ExecutionPayload( "test", String, "stringPayload" );
		var anotherMockPayload 			= new ExecutionPayload( anotherMockImplementation, IMockType, "anotherMockPayload" );
		
		var payloads 					: Array<ExecutionPayload> 	= [ mockPayload, stringPayload, anotherMockPayload ];
		PayloadUtil.mapPayload( payloads, injector );
		
        Assert.deepEquals( 	[[mockImplementation, IMockType, "mockPayload"], ["test", String, "stringPayload"], [anotherMockImplementation, IMockType, "anotherMockPayload"] ], 
									injector.mappedPayloads,
									"'CommandExecutor.mapPayload' should map right values" );
    }
	
	@Test( "Test unmapping" )
    public function testUnmapping() : Void
    {
		var injector 					= new MockDependencyInjectorForMapping();
		
		var mockImplementation 			= new MockImplementation( "mockImplementation" );
		var anotherMockImplementation 	= new MockImplementation( "anotherMockImplementation" );
		
		var mockPayload 				= new ExecutionPayload( mockImplementation, IMockType, "mockPayload" );
		var stringPayload 				= new ExecutionPayload( "test", String, "stringPayload" );
		var anotherMockPayload 			= new ExecutionPayload( anotherMockImplementation, IMockType, "anotherMockPayload" );
		
		var payloads 					: Array<ExecutionPayload> 	= [ mockPayload, stringPayload, anotherMockPayload ];
		PayloadUtil.unmapPayload( payloads, injector );
		
        Assert.deepEquals( 	[[IMockType, "mockPayload"], [String, "stringPayload"], [IMockType, "anotherMockPayload"] ], 
									injector.unmappedPayloads,
									"'CommandExecutor.mapPayload' should unmap right values" );
    }
	
	@Test( "Test mapping with class name" )
    public function testMappingWithClassName() : Void
    {
		var injector 					= new MockDependencyInjectorForMapping();
		
		var mockImplementation 			= new MockImplementation( "mockImplementation" );
		var anotherMockImplementation 	= new MockImplementation( "anotherMockImplementation" );
		
		var mockPayload 				= new ExecutionPayload( mockImplementation, IMockType, "mockPayload" ).withClassName( 'MockImplementation' );
		var stringPayload 				= new ExecutionPayload( "test", String, "stringPayload" );
		var anotherMockPayload 			= new ExecutionPayload( anotherMockImplementation, IMockType, "anotherMockPayload" ).withClassName( 'MockImplementation' );
		
		var payloads 					: Array<ExecutionPayload> 	= [ mockPayload, stringPayload, anotherMockPayload ];
		PayloadUtil.mapPayload( payloads, injector );
		
        Assert.deepEquals( 	[[mockImplementation, 'MockImplementation', "mockPayload"], ["test", String, "stringPayload"], [anotherMockImplementation, 'MockImplementation', "anotherMockPayload"] ], 
									injector.mappedPayloads,
									"'CommandExecutor.mapPayload' should map right values" );
    }
	
	@Test( "Test unmapping with class name" )
    public function testUnmappingWithClassName() : Void
    {
		var injector 					= new MockDependencyInjectorForMapping();
		
		var mockImplementation 			= new MockImplementation( "mockImplementation" );
		var anotherMockImplementation 	= new MockImplementation( "anotherMockImplementation" );
		
		var mockPayload 				= new ExecutionPayload( mockImplementation, IMockType, "mockPayload" ).withClassName( 'MockImplementation' );
		var stringPayload 				= new ExecutionPayload( "test", String, "stringPayload" );
		var anotherMockPayload 			= new ExecutionPayload( anotherMockImplementation, IMockType, "anotherMockPayload" ).withClassName( 'MockImplementation' );
		
		var payloads 					: Array<ExecutionPayload> 	= [ mockPayload, stringPayload, anotherMockPayload ];
		PayloadUtil.unmapPayload( payloads, injector );
		
        Assert.deepEquals( 	[['MockImplementation', "mockPayload"], [String, "stringPayload"], ['MockImplementation', "anotherMockPayload"] ], 
									injector.unmappedPayloads,
									"'CommandExecutor.mapPayload' should unmap right values" );
    }
}

private class MockDependencyInjectorForMapping extends MockDependencyInjector
{
	public var mappedPayloads 						: Array<Array<Dynamic>> = [];
	public var unmappedPayloads 					: Array<Array<Dynamic>> = [];
	
	override public function mapToValue( clazz : Class<Dynamic>, value : Dynamic, ?name : String = '' ) : Void 
	{
		this.mappedPayloads.push( [ value, clazz, name ] );
	}
	
	override public function unmap( type : Class<Dynamic>, name : String = '' ) : Void 
	{
		this.unmappedPayloads.push( [ type, name ] );
	}
	
	override public function mapClassNameToValue( className : String, value : Dynamic, ?name : String = '' ) : Void 
	{
		this.mappedPayloads.push( [ value, className, name ] );
	}
	
	override public function unmapClassName( className : String, name : String = '' ) : Void
	{
		this.unmappedPayloads.push( [ className, name ] );
	}
}

private class MockDependencyInjector implements IDependencyInjector
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
	
	public function getInstance<T>( type : Class<T>, name : String = '', targetType : Class<Dynamic> = null ) : T 
	{
		return null;
	}
	
	public function getInstanceWithClassName<T>( className : String, name : String = '', targetType : Class<Dynamic> = null, shouldThrowAnError : Bool = true ) : T
	{
		return null;
	}
	
	public function getOrCreateNewInstance<T>( type : Class<Dynamic> ) : T 
	{
		return null;
	}
	
	public function instantiateUnmapped<T>( type : Class<Dynamic> ) : T 
	{
		return null;
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
	
	public function getProvider<T>( className : String, name : String = '' ) : IDependencyProvider<T>
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