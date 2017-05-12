package hex.di.mapping;

/**
 * @author Francis Bourre
 */
typedef Mapping = MappingDef<Any, Any>;

typedef MappingDef<A, T> =
{
	var type 					: A;
	@:optional var name 		: String;
	
	@:optional var classValue 	: Class<T>;
	@:optional var refValue 	: T;
	
	@:optional var asSingleton 	: Bool;
	@:optional var injectInto 	: Bool;
}