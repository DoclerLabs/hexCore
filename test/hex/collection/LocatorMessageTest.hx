package hex.collection;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessageTest
{
	public function new() { }
	
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( LocatorMessage );
	}
	
	@Test( "test 'REGISTER' property" ) 
	public function testRegisterProperty() : Void
	{
		var message = LocatorMessage.REGISTER;
		Assert.equals( "onRegister", message );
	}
	
	@Test( "test 'UNREGISTER' property" ) 
	public function testUnregisterProperty() : Void
	{
		var message = LocatorMessage.UNREGISTER;
		Assert.equals( "onUnregister", message );
	}
}