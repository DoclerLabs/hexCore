package hex.di;

/**
 * @author Francis Bourre
 */
@:keepSub
interface IDependencyInjector extends IBasicInjector
{
	function hasMapping( type : Class<Dynamic>, name : String = '' ) : Bool;
	
    function hasDirectMapping( type : Class<Dynamic>, name:String = '' ) : Bool;

    function satisfies( type : Class<Dynamic>, name : String = '' ) : Bool;

    function injectInto( target : Dynamic ) : Void;

    function destroyInstance( instance : Dynamic ) : Void;
	
	function unmap( type : Class<Dynamic>, name : String = '' ) : Void;
}