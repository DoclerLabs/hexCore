package hex.di;

/**
 * @author Francis Bourre
 */
interface IBasicInjector
{
    function mapToValue<T>( clazz : ClassRef<T>, value : T, ?name : MappingName ) : Void;

    function mapToType<T>( clazz : ClassRef<T>, type : Class<T>, ?name : MappingName ) : Void;

    function mapToSingleton<T>( clazz : ClassRef<T>, type : Class<T>, ?name : MappingName ) : Void;

    function getInstance<T>( type : ClassRef<T>, ?name : MappingName, targetType : Class<Dynamic> = null ) : T;
	
	function getInstanceWithClassName<T>( className : ClassName, ?name : MappingName, targetType : Class<Dynamic> = null, shouldThrowAnError : Bool = true ) : T;

    function instantiateUnmapped<T>( type : Class<T> ) : T;
	
	function getOrCreateNewInstance<T>( type : Class<T> ) : T;
	
	function hasMapping<T>( type : ClassRef<T>, ?name : MappingName ) : Bool;
	
	function unmap<T>( type : ClassRef<T>, ?name : MappingName ) : Void;
	
	function unmapClassName( className : ClassName, ?name : MappingName ) : Void;
	
	function mapClassNameToValue<T>( className : ClassName, value : T, ?name : MappingName ) : Void;

    function mapClassNameToType<T>( className : ClassName, type : Class<T>, ?name : MappingName ) : Void;

    function mapClassNameToSingleton<T>( className : ClassName, type : Class<T>, ?name : MappingName ) : Void;
}