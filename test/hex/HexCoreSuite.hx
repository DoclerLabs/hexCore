package hex;

import hex.di.CoreDiSuite;
import hex.collection.CoreCollectionSuite;
import hex.core.CoreCoreSuite;
import hex.domain.CoreDomainSuite;
import hex.event.CoreEventSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexCoreSuite
{
    @Suite( "HexCore" )
    public var list : Array<Class<Dynamic>> = [ CoreEventSuite, CoreCollectionSuite, CoreCoreSuite, CoreDiSuite, CoreDomainSuite ];
}
