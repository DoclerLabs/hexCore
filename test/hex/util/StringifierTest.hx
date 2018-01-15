package hex.util;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class StringifierTest 
{
	public function new() { }
	
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( Stringifier );
	}

	@Test( "test accessors" ) 
	public function testAccessors() : Void
	{
		Stringifier.stringify( 'test' );
		Assert.isNotNull( Stringifier.getStringifier() );
		Assert.isInstanceOf( Stringifier.getStringifier(), BasicStringifierStrategy );
		
		var stringifier = new MockStringifierStrategy();
		Stringifier.setStringifier( stringifier );
		Assert.equals( stringifier, Stringifier.getStringifier() );
	}
}

private class MockStringifierStrategy implements IStringifierStrategy
{
	public function new() { }
	
	public function stringify( target : Dynamic ) : String 
	{
		return 'test';
	}
}