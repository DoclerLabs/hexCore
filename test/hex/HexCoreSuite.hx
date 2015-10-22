package hex;

import hex.collection.CollectionSuite;
import hex.core.CoreSuite;
import hex.domain.DomainSuite;
import hex.event.EventSuite;
import hex.inject.InjectorTest;

/**
 * ...
 * @author Francis Bourre
 */
class HexCoreSuite
{
    @suite( "ExMachina suite" )
    public var list : Array<Class<Dynamic>> = [CollectionSuite, CoreSuite, DomainSuite, EventSuite, InjectorTest];
}
