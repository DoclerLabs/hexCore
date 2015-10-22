package hex.error;

import haxe.PosInfos;

/**
 * ...
 * @author Francis Bourre
 */
class IllegalStateException extends Exception
{
    public function new ( message : String, ?posInfos : PosInfos )
    {
        super( message, posInfos );
    }
}