package hex.control.guard;

import hex.di.IBasicInjector;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class GuardUtil
{
	function new() 
	{
		throw new PrivateConstructorException( "'GuardUtil' class can't be instantiated." );
	}
	
	/**
	 * Approve guards
	 * @param	guards
	 * @param	injector
	 * @return
	 */
    static public function guardsApprove( ?guards : Array<Dynamic>, ?injector : IBasicInjector ) : Bool
    {
        if ( guards != null )
        {
            for ( guard in guards )
            {
                if ( Reflect.hasField( guard, "approve" ) )
				{
                    guard = Reflect.field( guard, "approve" );
                }
                else if ( Std.is( guard, Class ) )
                {
                    var scope = injector != null ? injector.instantiateUnmapped( guard ) : Type.createInstance( guard, [] );
					return Reflect.callMethod( scope, Reflect.field( scope, "approve" ), [] );
                }

                if ( Reflect.isFunction( guard ) )
                {
                    var b : Bool = guard();

                    if ( !b )
                    {
                        return false;
                    }
                }
            }
        }

        return true;
    }
}