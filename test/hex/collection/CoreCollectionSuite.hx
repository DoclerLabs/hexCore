package hex.collection;

/**
 * ...
 * @author Francis Bourre
 */
class CoreCollectionSuite
{
	@suite( "Collection" )
    public var list : Array<Class<Dynamic>> = [HashMapTest, LocatorTest];
}