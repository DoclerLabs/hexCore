package hex.util;

import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class Stringifier
{
    /** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }

    static var _STRATEGY : IStringifierStrategy;

    /**
     * Sets the concrete stringifier to be used.
     *
     * @param	stringifier Stringifier concrete implementation
     *
     * @see hex.log.BasicStringifierStrategy
     */
    public static function setStringifier( stringifier : IStringifierStrategy ) : Void
    {
        Stringifier._STRATEGY = stringifier;
    }

    /**
     * Returns the current stringifier used.
     */
    public static function getStringifier() : IStringifierStrategy
    {
        return Stringifier._STRATEGY;
    }

    /**
     * Process stringify processing.
     *
     * @param 	target  Object to stringified
     */
    public static function stringify<T>( target : T ) : String
    {
        if ( Stringifier._STRATEGY == null )
        {
            Stringifier._STRATEGY = new BasicStringifierStrategy();
        }

        return Stringifier._STRATEGY.stringify( target );
    }
}
