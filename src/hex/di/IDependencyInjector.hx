package hex.di;

/**
 * @author Francis Bourre
 */
@:keepSub
interface IDependencyInjector 
{
	function hasMapping( type : Class<Dynamic>, name : String = '' ) : Bool;
	
    function hasDirectMapping( type : Class<Dynamic>, name:String = '' ) : Bool;

    function satisfies( type : Class<Dynamic>, name : String = '' ) : Bool;

    function injectInto( target : Dynamic ) : Void;

    function getInstance( type : Class<Dynamic>, name : String = '', targetType : Class<Dynamic> = null) : Dynamic;

    function getOrCreateNewInstance( type : Class<Dynamic> ) : Dynamic;

    function instantiateUnmapped( type : Class<Dynamic> ) : Dynamic;

    function destroyInstance( instance : Dynamic ) : Void;
	
	function mapToValue( clazz : Class<Dynamic>, value : Dynamic, ?name : String = '' ) : Void;
	
	function mapToType( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;
	
	function mapToSingleton( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;
	
	function unmap( type : Class<Dynamic>, name : String = '' ) : Void;
}