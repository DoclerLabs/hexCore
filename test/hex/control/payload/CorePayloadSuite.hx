package hex.control.payload;

/**
 * ...
 * @author Francis Bourre
 */
class CorePayloadSuite
{
	@Suite( "Payload" )
    public var list : Array<Class<Dynamic>> = [ ExecutionPayloadTest, PayloadUtilTest ];
}