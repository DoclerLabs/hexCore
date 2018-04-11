package hex.error;

import haxe.PosInfos;
using tink.CoreApi;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class NullPointerException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}