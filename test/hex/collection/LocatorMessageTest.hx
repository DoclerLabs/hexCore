package hex.collection;

import hex.event.MessageType;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessageTest
{
	function new() 
	{
		
	}
	
	@Test( "test register property" ) 
	public function testRegisterProperty() : Void
	{
		var register = LocatorMessage.REGISTER;
		Assert.isInstanceOf( register, MessageType, "'LocatorMessage.REGISTER' should be an instance of 'MessageType'" );
		Assert.equals( "onRegister", register.name, "'name' property should be the same" );
	}
	
	@Test( "test unregister property" ) 
	public function testUnregisterProperty() : Void
	{
		var unregister = LocatorMessage.UNREGISTER;
		Assert.isInstanceOf( unregister, MessageType, "'LocatorMessage.UNREGISTER' should be an instance of 'MessageType'" );
		Assert.equals( "onUnregister", unregister.name, "'name' property should be the same" );
	}
}