package hex.core;

import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
@:final 
class HashCodeFactory
{
    /** @private */
    function new()
    {
        throw new PrivateConstructorException( "This class can't be instantiated." );
    }

    static var _nKEY    : Int               = 0;
    static var _M       = new Map<{}, Int>();

    public static function getNextKEY() : Int
    {
        return HashCodeFactory._nKEY++;
    }

    public static function getNextName() : String
    {
        return "" + HashCodeFactory._nKEY;
    }

    public static function getKey( o : Dynamic ) : Int
    {
        if ( !HashCodeFactory._M.exists( o ) )
        {
            HashCodeFactory._M.set( o, HashCodeFactory.getNextKEY() );
        }

        return HashCodeFactory._M.get( o );
    }

    public static function previewNextKey() : Int
    {
        return HashCodeFactory._nKEY;
    }
}
