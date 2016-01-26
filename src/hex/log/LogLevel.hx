package hex.log;

/**
 * ...
 * @author Francis Bourre
 */
class LogLevel
{
    static var _ALL 	= new LogLevel( 0 );
    static var _DEBUG 	= new LogLevel( 10000 );
    static var _INFO 	= new LogLevel( 20000 );
    static var _WARN 	= new LogLevel( 30000 );
    static var _ERROR 	= new LogLevel( 40000 );
    static var _FATAL 	= new LogLevel( 50000 );
    static var _OFF 	= new LogLevel( 60000 );

    @:isVar public static var ALL( get, null ) : LogLevel;
    inline static function get_ALL() : LogLevel
    {
        return LogLevel._ALL;
    }

    @:isVar public static var DEBUG( get, null ) : LogLevel;
    inline static function get_DEBUG() : LogLevel
    {
        return LogLevel._DEBUG;
    }

    @:isVar public static var INFO( get, null ) : LogLevel;
    inline static function get_INFO() : LogLevel
    {
        return LogLevel._INFO;
    }

    @:isVar public static var WARN( get, null ) : LogLevel;
    inline static function get_WARN() : LogLevel
    {
        return LogLevel._WARN;
    }

    @:isVar public static var ERROR( get, null ) : LogLevel;
    inline static function get_ERROR() : LogLevel
    {
        return LogLevel._ERROR;
    }

    @:isVar public static var FATAL( get, null ) : LogLevel;
    inline static function get_FATAL() : LogLevel
    {
        return LogLevel._FATAL;
    }

    @:isVar public static var OFF( get, null ) : LogLevel;
    inline static function get_OFF() : LogLevel
    {
        return LogLevel._OFF;
    }

    @:isVar public var value( get, null ) : Int;
    function get_value() : Int
    {
        return this.value;
    }

    public function new( value : Int )
    {
        this.value = value;
    }
	
	public function toString() : String
	{
		switch( this.value )
		{
			case 0 :
				return "ALL";
			case 10000 :
				return "DEBUG";
			case 20000 :
				return "INFO";
			case 30000 :
				return "WARN";
			case 40000 :
				return "ERROR";
			case 50000 :
				return "FATAL";
			case 60000 :
				return "OFF";
		}
		
		return "";
	}
}