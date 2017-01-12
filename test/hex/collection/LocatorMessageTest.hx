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
		Assert.equals( "onRegister", message );
	}
	
	@Test( "test 'UNREGISTER' property" ) 
	public function testUnregisterProperty() : Void
	{
		var message = LocatorMessage.UNREGISTER;
		Assert.equals( "onUnregister", message );
	}
}