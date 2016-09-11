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
	#if !neko
    public var list : Array<Class<Dynamic>> = [ AsyncHandlerTest, AsyncHandlerUtilTest, AsyncResponderTest, CoreGuardSuite, CorePayloadSuite ];
	#else
	public var list : Array<Class<Dynamic>> = [ AsyncHandlerTest, AsyncResponderTest, CoreGuardSuite, CorePayloadSuite ];
	#end
}