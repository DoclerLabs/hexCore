package hex.di.mapping;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class MappingDefinitionTest
{
	@Test( "Test constructor" )
	public function testConstructor() : Void
	{
		var mapping = new MappingDefinition( MappingDefinitionTest, "test" );
		Assert.equals( MappingDefinitionTest, mapping.type, "type should be the same" );
		Assert.equals( "test", mapping.name, "name should be the same" );
	}
	
	@Test( "Test constructor call wihtout name" )
	public function testConstructorCallWithoutName() : Void
	{
		var mapping = new MappingDefinition( MappingDefinitionTest );
		Assert.equals( MappingDefinitionTest, mapping.type, "type should be the same" );
		Assert.equals( "", mapping.name, "name should be an empty String" );
	}
}