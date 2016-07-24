package hex.control.payload;

import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.log.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
class ExecutionPayload
{
    var _data : Dynamic;
    var _type : Class<Dynamic>;
    var _name : String;

    public function new( data : Dynamic, type : Class<Dynamic>, name : String = "" )
    {
        if ( data == null )
        {
            throw new NullPointerException( "ExecutionPayload data can't be null" );
        }
		else if ( !Std.is( data, type ) )
		{
			throw new IllegalArgumentException( "ExecutionPayload data '" + data + "' should be an instance of type '" + type + "'" );
		}

        this._data = data;
        this._type = type;
        this._name = name;
    }

    public function getData() : Dynamic
    {
        return this._data;
    }

    public function getType() : Class<Dynamic>
    {
        return this._type;
    }

    public function getName() : String
    {
        return this._name;
    }

    public function withClass( type : Class<Dynamic> ) : ExecutionPayload
    {
        this._type = type;
        return this;
    }

    public function withName( name : String ) : ExecutionPayload
    {
        this._name = name != null ? name : "";
        return this;
    }
}
