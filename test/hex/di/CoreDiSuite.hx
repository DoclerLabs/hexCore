package hex.di;

import hex.di.mapping.MappingDefinitionTest;

/**
 * ...
 * @author Francis Bourre
 */
class CoreDiSuite
{
    @Suite( "Di" )
    public var list : Array<Class<Dynamic>> = [ InjectionEventTest, MappingDefinitionTest ];
	
}