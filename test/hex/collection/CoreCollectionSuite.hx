package hex.collection;

/**
 * ...
 * @author Francis Bourre
 */
class CoreCollectionSuite
{
	@Suite( "Collection" )
    public var list : Array<Class<Dynamic>> = [HashMapTest, LocatorTest];
}