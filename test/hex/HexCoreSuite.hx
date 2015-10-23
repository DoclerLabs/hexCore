package hex;

import hex.collection.CollectionSuite;
import hex.core.CoreSuite;
import hex.domain.DomainSuite;
import hex.event.EventSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexCoreSuite
{
    @suite( "HexCore suite" )
    public var list : Array<Class<Dynamic>> = [CollectionSuite, CoreSuite, DomainSuite, EventSuite];
}
