package hex;

import hex.collection.CoreCollectionSuite;
import hex.control.CoreControlSuite;
import hex.core.CoreCoreSuite;
import hex.data.CoreDataSuite;
import hex.di.CoreDiSuite;
import hex.domain.CoreDomainSuite;
import hex.event.CoreEventSuite;
import hex.model.CoreModelSuite;
import hex.module.CoreModuleSuite;
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
    public var list : Array<Class<Dynamic>> = 
	[ 
		CoreCollectionSuite, 
		CoreControlSuite, 
		CoreCoreSuite, 
		CoreDataSuite, 
		CoreDiSuite, 
		CoreDomainSuite, 
		CoreEventSuite, 
		CoreModelSuite, 
		CoreModuleSuite, 
		CoreServiceSuite, 
		CoreStructuresSuite, 
		CoreUtilSuite 
	];
}
