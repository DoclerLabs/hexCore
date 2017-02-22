package hex.control.payload;

import hex.error.NullPointerException;

/**
 * ...
 * @author Francis Bourre
 */
class ExecutionPayload
{
    var _data 		: Dynamic;
    var _type 		: Class<Dynamic>;
    var _className 	: String;
    var _name 		: String;
	
    public function new( data : Dynamic, type : Class<Dynamic> = null, name : String = "" )
    {
        if ( data == null )
        {
            throw new NullPointerException( "ExecutionPayload data can't be null" );
        }

        this._data 		= data;
		
		if ( type != null )
		{
			this._type 	= type;
		}
		else
		{
			this._type 	= Type.getClass( this._data );
		}
        
        this._name 		= name;
    }

    public function getData() : Dynamic
    {
        return this._data;
    }

    public function getType() : Class<Dynamic>
    {
        return this._type;
    }
	
	/**
	 * 
	 * @return 	null when withClassName was not called
	 */
	public function getClassName() : String
    {
        return this._className;
    }

    public function getName() : String
    {
        return this._name;
    }

    public function withName( name : String ) : ExecutionPayload
    {
        this._name = name;
        return this;
    }
	
	public function withClassName( className : String ) : ExecutionPayload
    {
        this._type 	= Type.resolveClass( className.split( '<' )[ 0 ] );
        this._className = className.split( " " ).join( '' );
        return this;
    }
}
