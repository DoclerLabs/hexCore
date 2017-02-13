package hex.log;

import haxe.PosInfos;
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

    //--------------------------------------------------------------------
    // Private properties
    //--------------------------------------------------------------------

    static var _STRATEGY : IStringifierStrategy;

    //--------------------------------------------------------------------
    // Public API
    //--------------------------------------------------------------------

    /**
     * Sets the concrete stringifier to use for process.
     *
     * @param       o Stringifier concrete implementation
     *
     * @see BasicStringifier
     */
    public static function setStringifier( o : IStringifierStrategy ) : Void
    {
        Stringifier._STRATEGY = o;
    }

    /**
     * Returns the current used stringifier.
     */
    public static function getStringifier() : IStringifierStrategy
    {
        return Stringifier._STRATEGY;
    }

    /**
     * Process stringify processing.
     *
     * @param       target  Object to stringify
     */
    public static function stringify( target : Dynamic ) : String
    {
        if ( Stringifier._STRATEGY == null )
        {
            Stringifier._STRATEGY = new BasicStringifierStrategy();
        }

        return Stringifier._STRATEGY.stringify( target );
    }

    /**
     * Returns the current code postion informations.
     */
    public static function getPosInfos( ?posInfos : PosInfos ) : PosInfos
    {
        return posInfos;
    }
}
