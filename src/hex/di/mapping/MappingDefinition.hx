package hex.di.mapping;

/**
 * ...
 * @author Francis Bourre
 */
class MappingDefinition
{
	public var type : Class<Dynamic>;
	public var name : String;
	
	public function new( type : Class<Dynamic>, name : String = "" ) 
	{
		this.type = type;
		this.name = name;
	}
	
	public function toString() : String
	{
		return Type.getClassName( this.type ) + "|" + this.name;
	}
}