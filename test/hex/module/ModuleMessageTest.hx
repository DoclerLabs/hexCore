package hex.module;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ModuleMessageTest
{
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( ModuleMessage );
	}
	
	@Test( "test 'INITIALIZED' property" ) 
	public function testInitializedProperty() : Void
	{
		var message = ModuleMessage.INITIALIZED;
		Assert.equals( "onModuleInitialisation", message );
	}
	
	@Test( "test 'RELEASED' property" ) 
	public function testReleasedProperty() : Void
	{
		var message = ModuleMessage.RELEASED;
		Assert.equals( "onModuleRelease", message );
	}
}