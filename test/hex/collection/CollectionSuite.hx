package hex.collection;

/**
 * ...
 * @author Francis Bourre
 */
class CollectionSuite
{
	@suite( "Core suite" )
    public var list : Array<Class<Dynamic>> = [HashMapTest, LocatorTest];
}