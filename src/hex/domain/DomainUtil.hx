package hex.domain;

import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class DomainUtil
{
	static var _domain = new Map<String,Dynamic>();
	
	/** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }
	
	static public function getDomain<DomainType:Domain>( domainName : String, type : Class<DomainType> ) : DomainType
	{
		var domain : DomainType = null;
		
		if ( DomainUtil._domain.exists( domainName ) )
		{
			domain = DomainUtil._domain.get( domainName );
		}
		else
		{
			domain = Type.createInstance( type, [ domainName ] );
			DomainUtil._domain.set( domainName, domain );
		}
		
		return domain;
	}
}