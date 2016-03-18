package hex.di;

/**
 * @author Francis Bourre
 */
interface IBasicInjector
{
    function mapToValue( clazz : Class<Dynamic>, value : Dynamic, ?name : String = '' ) : Void;

    function mapToType( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;

    function mapToSingleton( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;

    function getInstance( type : Class<Dynamic>, name : String = '', targetType : Class<Dynamic> = null ) : Dynamic;

    function instantiateUnmapped( type : Class<Dynamic> ) : Dynamic;

    function getOrCreateNewInstance( type : Class<Dynamic> ) : Dynamic;
	
	function hasMapping( type : Class<Dynamic>, name : String = '' ) : Bool;
	
	function unmap( type : Class<Dynamic>, name : String = '' ) : Void;
}