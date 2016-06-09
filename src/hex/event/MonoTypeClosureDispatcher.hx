package hex.event;

import haxe.Constraints.Constructible;
import hex.error.IllegalArgumentException;

/**
 * ...
 * @author Francis Bourre
 */
@:generic
class MonoTypeClosureDispatcher<EventType:Constructible<String->Dynamic->Void>>
{
    var _eventType      	: String;
    var _target      		: Dynamic;
    var _callbacks      	: Array<EventType->Void>;

    public function new( eventType : String, ?target : Dynamic )
    {
		this._eventType 			= eventType;
		this._target 				= target;
        this._callbacks         	= [];
    }

    public function dispatchEvent( ?e : EventType ) : Void
    {
		#if ( haxe_ver >= "3.3" )
		if ( e == null )
		{
			e = new EventType( this._eventType, this._target );
		}
		#else
		if ( e != null && e.type != this._eventType )
		{
			throw new IllegalArgumentException( this + ".dispatchEvent failed. '" + e.type +"' should be '" + this._eventType + "'" );
		}
		#end
		
		for ( f in this._callbacks )
		{
			f( e );
		}
    }

    public function addEventListener( callback : EventType->Void ) : Bool
    {
        var index : Int = this._callbacks.indexOf( callback );
        if ( index == -1 )
        {
            this._callbacks.push( callback );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function removeEventListener( callback : EventType->Void ) : Bool
    {
        var index : Int = this._callbacks.indexOf( callback );
        if ( index == -1 )
        {
            return false;
        }
        else
        {
            this._callbacks.splice( index, 1 );
            return true;
        }
    }

    public function removeAllListeners() : Void
    {
        this._callbacks = [];
    }

    public function isEmpty() : Bool
    {
        return this._callbacks.length == 0;
    }
}
