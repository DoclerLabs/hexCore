package hex.error;

import haxe.PosInfos;

/**
 * ...
 * @author Francis Bourre
 */
class NoSuchElementException  extends Exception
{
    public function new ( message : String, ?posInfos : PosInfos )
    {
        super( message, posInfos );
    }
}