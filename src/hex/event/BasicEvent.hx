package hex.event;

import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class BasicEvent
{
    public var type     : String;
    public var target   : Dynamic;

    public function new( type : String, target : Dynamic )
    {
        this.type   = type;
        this.target = target;
    }

    public function clone() : BasicEvent
    {
        return new BasicEvent( this.type, this.target );
    }

    public function toString() : String
    {
        return Stringifier.stringify( this ) + ':{ type:$type, target:$target }';
    }
}
