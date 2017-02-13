package hex.control;

import hex.control.payload.CorePayloadSuite;

/**
 * ...
 * @author Francis Bourre
 */
class CoreControlSuite
{
	@Suite( "Control" )
	#if !neko
    public var list : Array<Class<Dynamic>> = [ AsyncHandlerTest, AsyncHandlerUtilTest, AsyncResponderTest, CorePayloadSuite ];
	#else
	public var list : Array<Class<Dynamic>> = [ AsyncHandlerTest, AsyncResponderTest, CorePayloadSuite ];
	#end
}