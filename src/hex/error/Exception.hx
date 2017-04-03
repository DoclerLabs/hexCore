package hex.error;

import haxe.PosInfos;
import hex.util.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class Exception
{
    public var name 	: String;
    public var message  : String;
    public var posInfos : PosInfos;

    public function new ( message : String, ?posInfos : PosInfos )
    {
        this.message    = message;
        this.posInfos   = posInfos;
        this.name       = Stringifier.stringify( this );
    }

    public function toString() : String
    {
        return (this.posInfos != null ?
            this.name + " at " + this.posInfos.className + "#" + this.posInfos.methodName + " line:" + this.posInfos.lineNumber + " in file '" + this.posInfos.fileName + "'"
                : this.name) + " | " + this.message;
    }
}