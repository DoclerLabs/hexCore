package hex.error;

import haxe.PosInfos;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class VirtualMethodException extends Exception
{
    public function new ( ?message : String = 'this method must be overridden', ?posInfos : PosInfos )
    {
        super( message, posInfos );
    }
}