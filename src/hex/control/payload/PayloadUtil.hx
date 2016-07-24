package hex.control.payload;

import hex.di.IBasicInjector;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class PayloadUtil
{
	public function new() 
	{
		throw new PrivateConstructorException( "'PayloadUtil' class can't be instantiated." );
	}
	
	/**
	 * Map payloads
	 * @param	payload
	 */
    static public function mapPayload( payloads : Array<ExecutionPayload>, injector : IBasicInjector ) : Void
    {
        for ( payload in payloads ) 
		{
			injector.mapToValue( payload.getType(), payload.getData(), payload.getName() );
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
			injector.unmap( payload.getType(), payload.getName() );
		}
    }
	
}