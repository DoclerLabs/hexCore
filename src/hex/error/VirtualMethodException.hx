package hex.error;

import haxe.PosInfos;
using tink.CoreApi;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class VirtualMethodException extends Error
{
    public function new ( ?message : String = 'this method must be overridden', ?posInfos : PosInfos ) super( code, message, pos );
}