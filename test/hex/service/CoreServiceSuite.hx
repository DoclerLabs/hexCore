package hex.service;

/**
 * ...
 * @author Tamas Kinsztler
 */
class CoreServiceSuite
{
    @Suite( "Service" )
    public var list : Array<Class<Dynamic>> = [ ServiceConfigurationTest ];
}