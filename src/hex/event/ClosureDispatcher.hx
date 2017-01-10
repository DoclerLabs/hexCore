package hex.event;

import haxe.Constraints.Function;

/**
 * ...
 * @author Francis Bourre
 */
class ClosureDispatcher implements IClosureDispatcher
{
    var _callbacks 			: Map<String, Array<Function>>;
    var _callbackSize   	: UInt;

	public function new()
    {
        this._callbacks 	= new Map();
		this._callbackSize 	= 0;
    }
	
	public function dispatch( messageType : MessageType, ?data : Array<Dynamic> ) : Void
    {
        if ( this._callbacks.exists( messageType ) )
        {
			var callbacks = this._callbacks.get( messageType ).copy();
            for ( f in callbacks )
            {
				Reflect.callMethod( null, f, data );
            }
        }
    }
	
	public function addHandler( messageType : MessageType, callback : Function ) : Bool
    {
        if ( !this._callbacks.exists( messageType ) )
        {
            this._callbacks.set( messageType, [] );
        }

        var callbacks = this._callbacks.get( messageType );

		#if !neko
		var index : Int = callbacks.indexOf( callback );
        if ( index == -1 )
        {
            callbacks.push( callback );
            this._callbackSize++;
            return true;
        }
        else
        {
            return false;
        }
		#else
		for ( c in callbacks )
		{
			if ( Reflect.compareMethods( c, callback ) )
			{
				return false;
			}
		}
		
		callbacks.push( callback );
		this._callbackSize++;
		return true;
		#end
    }
	
	public function removeHandler( messageType : MessageType, callback : Function ) : Bool
	{
        if ( !this._callbacks.exists( messageType ) )
        {
            return false;
        }

		var callbacks = this._callbacks.get( messageType );
		
		#if !neko
		var index : Int = callbacks.indexOf( callback );
        if ( index == -1 )
        {
            return false;
        }
        else
        {
            callbacks.splice( index, 1 );
            this._callbackSize--;

            if ( callbacks.length == 0 )
            {
                this._callbacks.remove( messageType );
            }

            return true;
        }
		#else
		var length = callbacks.length;
		for ( index in 0...length )
		{
			var method = callbacks[ index ];
			if ( Reflect.compareMethods( method, callback ) )
			{
				callbacks.splice( index, 1 );
				this._callbackSize--;

				if ( callbacks.length == 0 )
				{
					this._callbacks.remove( messageType );
				}

				return true;
			}
		}
	
		return false;
		#end
    }

	public function removeAllListeners() : Void
    {
		this._callbacks 		= new Map();
		this._callbackSize      = 0;
    }

	public function isEmpty() : Bool
    {
        return this._callbackSize == 0;
    }

    public function hasHandler( messageType : MessageType, ?callback : Function ) : Bool
    {
        if ( !this._callbacks.exists( messageType ) )
        {
            return false;
        }

        if ( callback == null )
        {
            return true;
        }
        else
        {
            #if !neko
            return this._callbacks.get( messageType ).indexOf( callback ) != -1;
			#else
			var closures = this._callbacks.get( messageType );
			for ( closure in closures )
			{
				if ( Reflect.compareMethods( closure, callback ) )
				{
					return true;
				}
			}
			
			return false;
			#end
        }
    }
}