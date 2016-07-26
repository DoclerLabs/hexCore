package hex.domain;

import hex.domain.Domain;
import hex.domain.DomainDispatcher;
import hex.domain.NoDomain;
import hex.event.Dispatcher;
import hex.event.IDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class ApplicationDomainDispatcher extends DomainDispatcher<{}> implements IApplicationDomainDispatcher
{
	static var _Instance = new ApplicationDomainDispatcher();

	function new() 
	{
		super( TopLevelDomain.DOMAIN, Dispatcher );
	}
	
	static public function getInstance() : ApplicationDomainDispatcher
	{
		return ApplicationDomainDispatcher._Instance;
	}
	
	override public function getDomainDispatcher( ?domain : Domain ) : IDispatcher<{}>
	{
		return ( domain != NoDomain.DOMAIN ) ? super.getDomainDispatcher( domain ) : null;
	}
}