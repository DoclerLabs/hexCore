package hex.di;

/**
 * @author Francis Bourre
 */
interface IBasicInjector
{
    function mapToValue<T>( clazz : Class<T>, value : T, ?name : String = '' ) : Void;

    function mapToType<T>( clazz : Class<T>, type : Class<T>, name : String = '' ) : Void;

    function mapToSingleton<T>( clazz : Class<T>, type : Class<T>, name : String = '' ) : Void;

    function getInstance<T>( type : Class<T>, name : String = '', targetType : Class<Dynamic> = null ) : T;
	
	function getInstanceWithClassName<T>( className : String, name : String = '', targetType : Class<Dynamic> = null ) : T;

    function instantiateUnmapped<T>( type : Class<T> ) : T;

    function getOrCreateNewInstance<T>( type : Class<T> ) : T;
	
	function hasMapping<T>( type : Class<T>, name : String = '' ) : Bool;
	
	function unmap<T>( type : Class<T>, name : String = '' ) : Void;
	
	function unmapClassName( className : String, name : String = '' ) : Void;
	
	function mapClassNameToValue<T>( className : String, value : T, ?name : String = '' ) : Void;

    function mapClassNameToType<T>( className : String, type : Class<T>, name : String = '' ) : Void;

    function mapClassNameToSingleton<T>( className : String, type : Class<T>, name : String = '' ) : Void;
}