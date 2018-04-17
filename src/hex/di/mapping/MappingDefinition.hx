package hex.di.mapping;

/**
 * @author Francis Bourre
 */
typedef MappingDefinition =
{
	var fromType 				: ClassName;
	@:optional var withName 	: MappingName;
	
	@:optional var toClass 		: Class<Dynamic>;
	@:optional var toValue 		: Any;
	
	@:optional var asSingleton 	: Bool;
	@:optional var injectInto 	: Bool;
}