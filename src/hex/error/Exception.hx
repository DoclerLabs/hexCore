package hex.error;

import hex.log.Logger;
import hex.log.Stringifier;
import haxe.PosInfos;

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
		
		#if debug
			Logger.error( this.toString() );
		#end
    }

    public function toString() : String
    {
        return (this.posInfos != null ?
            this.name + " at " + this.posInfos.className + "#" + this.posInfos.methodName + " line:" + this.posInfos.lineNumber + " in file '" + this.posInfos.fileName + "'"
                : this.name) + " | " + this.message;
    }
}