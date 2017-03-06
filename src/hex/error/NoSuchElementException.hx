package hex.error;

import haxe.PosInfos;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class NoSuchElementException  extends Exception
{
    public function new ( message : String, ?posInfos : PosInfos )
    {
        super( message, posInfos );
    }
}