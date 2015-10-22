package hex.log;

/**
 * ...
 * @author Francis Bourre
 */
class LogLevel
{
    private static var _ALL 	= new LogLevel( 0 );
    private static var _DEBUG 	= new LogLevel( 10000 );
    private static var _INFO 	= new LogLevel( 20000 );
    private static var _WARN 	= new LogLevel( 30000 );
    private static var _ERROR 	= new LogLevel( 40000 );
    private static var _FATAL 	= new LogLevel( 50000 );
    private static var _OFF 	= new LogLevel( 60000 );

    @:isVar public static var ALL( get, null ) : LogLevel;
    inline static private function get_ALL() : LogLevel
    {
        return LogLevel._ALL;
    }

    @:isVar public static var DEBUG( get, null ) : LogLevel;
    inline static private function get_DEBUG() : LogLevel
    {
        return LogLevel._DEBUG;
    }

    @:isVar public static var INFO( get, null ) : LogLevel;
    inline static private function get_INFO() : LogLevel
    {
        return LogLevel._INFO;
    }

    @:isVar public static var WARN( get, null ) : LogLevel;
    inline static private function get_WARN() : LogLevel
    {
        return LogLevel._WARN;
    }

    @:isVar public static var ERROR( get, null ) : LogLevel;
    inline static private function get_ERROR() : LogLevel
    {
        return LogLevel._ERROR;
    }

    @:isVar public static var FATAL( get, null ) : LogLevel;
    inline static private function get_FATAL() : LogLevel
    {
        return LogLevel._FATAL;
    }

    @:isVar public static var OFF( get, null ) : LogLevel;
    inline static private function get_OFF() : LogLevel
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
}