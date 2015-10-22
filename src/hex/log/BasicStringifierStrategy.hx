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
        return Type.getClassName( Type.getClass( target ) );//+ "#" + HashCodeFactory.getKey( target );
    }

    /**
     * @return The string representation of this instance
     */
    public function toString() : String
    {
        return Stringifier.stringify( this );
    }
}
