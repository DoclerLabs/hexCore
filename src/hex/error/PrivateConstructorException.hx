package hex.error;

import haxe.PosInfos;

/**
 * ...
 * @author Francis Bourre
 */
class PrivateConstructorException extends Exception
{
    public function new ( ?message : String = "This class can't be instantiated.", ?posInfos : PosInfos )
    {
        super( message, posInfos );
    }
}