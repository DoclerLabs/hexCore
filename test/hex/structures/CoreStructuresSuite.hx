package hex.structures;

/**
 * ...
 * @author Francis Bourre
 */
class CoreStructuresSuite
{
	@Suite( "Structures" )
    public var list : Array<Class<Dynamic>> = 
	[ 
		PointTest, 
		PointFTest, 
		PointFactoryTest,
		SizeTest 
	];
}