package hex.control.guard;

import hex.control.guard.GuardUtil;
import hex.control.guard.IGuard;
import hex.di.IDependencyInjector;
import hex.di.IInjectorListener;
import hex.di.provider.IDependencyProvider;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class GuardUtilTest
{
	@Test( "Test guard class approval without injector" )
    public function testGuardClassApprovalWithoutInjector() : Void
    {
        Assert.isTrue( GuardUtil.guardsApprove( [ MockApproveGuard ] ), "'GuardUtil.guardsApprove' property should return true" );
        Assert.isFalse( GuardUtil.guardsApprove( [ MockRefuseGuard ] ), "'GuardUtil.guardsApprove' property should return false" );
    }
	
	@Test( "Test mutiple guard classes approval without injector" )
    public function testMultipleGuardClassesApprovalWithoutInjector() : Void
    {
        Assert.isFalse( GuardUtil.guardsApprove( [ MockApproveGuard, MockRefuseGuard ] ), "'GuardUtil.guardsApprove' property should return false" );
    }
	
	@Test( "Test mixed guards approval without injector" )
    public function testMixedGuardsApprovalWithoutInjector() : Void
    {
		var fFalse = function() : Bool { return false; };
		var fTrue = function() : Bool { return true; };
        Assert.isFalse( GuardUtil.guardsApprove( [ MockApproveGuard, fFalse ] ), "'GuardUtil.guardsApprove' property should return false" );
        Assert.isFalse( GuardUtil.guardsApprove( [ fTrue, MockRefuseGuard ] ), "'GuardUtil.guardsApprove' property should return false" );
    }
	
	@Test( "Test guard-class approval with injector" )
    public function testGuardClassApprovalWithInjector() : Void
    {
		var injector = new MockDependencyInjectorForTestingGuard();
        Assert.isTrue( GuardUtil.guardsApprove( [ MockApproveGuard ], injector ), "'GuardUtil.guardsApprove' property should return true" );
        Assert.isFalse( GuardUtil.guardsApprove( [ MockRefuseGuard ], injector ), "'GuardUtil.guardsApprove' property should return false" );
    }
}

private class MockApproveGuard implements IGuard
{
	public function new()
	{
		
	}
	
	public function approve() : Bool
	{
		return true;
	}
}

private class MockRefuseGuard implements IGuard
{
	public function new()
	{
		
	}
	
	public function approve() : Bool
	{
		return false;
	}
}

private class MockDependencyInjectorForTestingGuard extends MockDependencyInjector
{
	public function new()
	{
		
	}
	
	override public function instantiateUnmapped<T>( type : Class<Dynamic> ) : T 
	{
		return Type.createInstance( type, [] );
	}
}

private class MockDependencyInjector implements IDependencyInjector
{
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