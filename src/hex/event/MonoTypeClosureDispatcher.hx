package hex.event;

#if ( haxe_ver >= "3.3" )
import haxe.Constraints.Constructible;
#end
import hex.error.IllegalArgumentException;

/**
 * ...
 * @author Francis Bourre
 */
#if ( haxe_ver >= "3.3" )
@:generic
class MonoTypeClosureDispatcher<EventType:Constructible<String->Dynamic->Void>>
#else
class MonoTypeClosureDispatcher<EventType:Event>
#end
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

	#if ( haxe_ver >= "3.3" )
    public function dispatchEvent( ?e : EventType ) : Void
	#else
	public function dispatchEvent( e : EventType ) : Void
	#end
    {
		#if ( haxe_ver >= "3.3" )
		if ( e == null )
		{
			e = new EventType( this._eventType, this._target );
		}
		#else
		if ( e == null )
		{
			throw new IllegalArgumentException( this + ".dispatchEvent failed." );
		}
		#end
		
		if ( e != null && (cast e).type != this._eventType )
		{
			throw new IllegalArgumentException( this + ".dispatchEvent failed. '" + (cast e).type +"' should be '" + this._eventType + "'" );
		}
		
		for ( f in this._callbacks )
		{
			f( e );
		}
    }

    public function addEventListener( callback : EventType->Void ) : Bool
    {
		#if !neko
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
		#else
		for ( method in this._callbacks )
		{
			if ( Reflect.compareMethods( method, callback ) )
			{
				return false;
			}
		}
		
		this._callbacks.push( callback );
		return true;
		#end
    }

    public function removeEventListener( callback : EventType->Void ) : Bool
    {
		#if !neko
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
		#else
		var length = this._callbacks.length;
		for ( index in 0...length )
		{
			var method = this._callbacks[ index ];
			if ( Reflect.compareMethods( method, callback ) )
			{
				this._callbacks.splice( index, 1 );
				return true;
			}
		}
		
		return false;
		#end
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
