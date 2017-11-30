package hex.util;

/**
 * ...
 * @author Francis Bourre
 */
class BasicStringifierStrategy implements IStringifierStrategy
{
    public function new()
    {
    }

    /**
	 * @inheritDoc
	 */
    public function stringify( target : Dynamic ) : String
    {
		var type = Type.getClass( target );
        return type != null ? Type.getClassName( type ) : "Dynamic";
    }

    /**
     * @return The string representation of this instance
     */
    public function toString() return Stringifier.stringify( this );
}
