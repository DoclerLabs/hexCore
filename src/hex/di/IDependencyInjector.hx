package hex.di;

/**
 * @author Francis Bourre
 */
interface IDependencyInjector extends IBasicInjector
{
    function hasDirectMapping( type : Class<Dynamic>, name:String = '' ) : Bool;

    function satisfies( type : Class<Dynamic>, name : String = '' ) : Bool;

    function injectInto( target : Dynamic ) : Void;

    function destroyInstance( instance : Dynamic ) : Void;

    function addEventListener( eventType : String, callback : InjectionEvent->Void ) : Bool;

    function removeEventListener( eventType : String, callback : InjectionEvent->Void ) : Bool;
}