package hex.control.payload;

import hex.di.IBasicInjector;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class PayloadUtil
{
	/** @private */
	function new() 
	{
		throw new PrivateConstructorException();
	}
	
	/**
	 * Map payloads
	 * @param	payload
	 */
    static public function mapPayload( payloads : Array<ExecutionPayload>, injector : IBasicInjector ) : Void
    {
        for ( payload in payloads ) 
		{
			var className = payload.getClassName();
			if ( className != null )
			{
				injector.mapClassNameToValue( payload.getClassName(), payload.getData(), payload.getName() );
			}
			else
			{
				injector.mapToValue( payload.getType(), payload.getData(), payload.getName() );
			}
		}
    }

	/**
	 * Unmap payloads
	 * @param	payloads
	 */
    static public function unmapPayload( payloads : Array<ExecutionPayload>, injector : IBasicInjector ) : Void
    {
        for ( payload in payloads ) 
		{
			var className = payload.getClassName();
			if ( className != null )
			{
				injector.unmapClassName( payload.getClassName(), payload.getName() );
			}
			else 
			{
				injector.unmap( payload.getType(), payload.getName() );
			}
		}
    }
}