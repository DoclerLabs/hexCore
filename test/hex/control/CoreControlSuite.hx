package hex.control;

import hex.control.guard.CoreGuardSuite;
import hex.control.payload.CorePayloadSuite;

/**
 * ...
 * @author Francis Bourre
 */
class CoreControlSuite
{
	@Suite( "Control" )
    public var list : Array<Class<Dynamic>> = [ AsyncResponderTest, CoreGuardSuite, CorePayloadSuite ];
}