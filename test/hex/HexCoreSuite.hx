package hex;

import hex.collection.CoreCollectionSuite;
import hex.core.CoreCoreSuite;
import hex.data.CoreDataSuite;
import hex.di.CoreDiSuite;
import hex.domain.CoreDomainSuite;
import hex.event.CoreEventSuite;
import hex.model.CoreModelSuite;
import hex.service.CoreServiceSuite;
import hex.structures.CoreStructuresSuite;
import hex.util.CoreUtilSuite;

/**
 * ...
 * @author Francis Bourre
 */
class HexCoreSuite
{
    @Suite( "HexCore" )
    public var list : Array<Class<Dynamic>> = [ CoreCollectionSuite, CoreCoreSuite, CoreDataSuite, CoreDiSuite, CoreDomainSuite, CoreEventSuite, CoreModelSuite, CoreServiceSuite, CoreStructuresSuite, CoreUtilSuite ];
}
