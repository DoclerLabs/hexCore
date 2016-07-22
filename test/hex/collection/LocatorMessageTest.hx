package hex.collection;

import hex.event.MessageType;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LocatorMessageTest
{
	@Test( "test 'REGISTER' property" ) 
	public function testRegisterProperty() : Void
	{
		var message = LocatorMessage.REGISTER;
		Assert.isInstanceOf( message, MessageType, "'LocatorMessage.REGISTER' should be an instance of 'MessageType'" );
		Assert.equals( "onRegister", message.name, "'name' property should be the same" );
	}
	
	@Test( "test 'UNREGISTER' property" ) 
	public function testUnregisterProperty() : Void
	{
		var message = LocatorMessage.UNREGISTER;
		Assert.isInstanceOf( message, MessageType, "'LocatorMessage.UNREGISTER' should be an instance of 'MessageType'" );
		Assert.equals( "onUnregister", message.name, "'name' property should be the same" );
	}
}