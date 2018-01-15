package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class PointFactoryTest 
{
	public function new() { }
	
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( PointFactory );
	}
	
	@Test( "test `build` method" ) 
	public function testBuildMethod() : Void
	{
		var p = PointFactory.build( 3, 5 );
		Assert.equals( 3, p.x );
		Assert.equals( 5, p.y );
	}
}