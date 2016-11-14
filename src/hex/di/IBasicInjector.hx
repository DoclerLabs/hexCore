package hex.di;

/**
 * @author Francis Bourre
 */
interface IBasicInjector
{
    function mapToValue( clazz : Class<Dynamic>, value : Dynamic, ?name : String = '' ) : Void;

    function mapToType( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;

    function mapToSingleton( clazz : Class<Dynamic>, type : Class<Dynamic>, name:String = '' ) : Void;

    function getInstance<T>( type : Class<T>, name : String = '' ) : T;
	
	function getInstanceWithClassName<T>( className : String, name : String = '' ) : T;

    function instantiateUnmapped( type : Class<Dynamic> ) : Dynamic;

    function getOrCreateNewInstance<T>( type : Class<T> ) : T;
	
	function hasMapping( type : Class<Dynamic>, name : String = '' ) : Bool;
	
	function unmap( type : Class<Dynamic>, name : String = '' ) : Void;
	
	function unmapClassName( className : String, name : String = '' ) : Void;
	
	function mapClassNameToValue( className : String, value : Dynamic, ?name : String = '' ) : Void;

    function mapClassNameToType( className : String, type : Class<Dynamic>, name:String = '' ) : Void;

    function mapClassNameToSingleton( className : String, type : Class<Dynamic>, name:String = '' ) : Void;
}