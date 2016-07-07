package hex.model;

/**
 * ...
 * @author Francis Bourre
 */
class CoreModelSuite
{
    @Suite( "Model" )
    public var list : Array<Class<Dynamic>> = [ ModelDispatcherTest ];
}