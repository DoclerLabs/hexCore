package hex.di;

abstract MappingName(String) {
	inline function new(s) this = s;
 	
	@:from static inline function ofString(s:String):MappingName
		return new MappingName(s);	
		
	@:to inline function toString()
		return if (this == null) '' else this;

	@:op(a | b) static function makeId(typeId:ClassName, name:MappingName) {
		return (typeId:String) + '|' + (name:String);
	}
}