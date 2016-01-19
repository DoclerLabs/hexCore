package hex.log;

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
        return type != null ? Type.getClassName( type ) : "Dynamic";//+ "#" + HashCodeFactory.getKey( target );
    }

    /**
     * @return The string representation of this instance
     */
    public function toString() : String
    {
        return Stringifier.stringify( this );
    }
}
