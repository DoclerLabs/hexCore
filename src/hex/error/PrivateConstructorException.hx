package hex.error;

import haxe.PosInfos;
using tink.CoreApi;

/**
 * ...
 * @author Francis Bourre
 */
@IgnoreCover
class PrivateConstructorException extends Error
{
    public function new ( ?message : String = "This class can't be instantiated.", ?posInfos : PosInfos ) super( code, message, pos );
}