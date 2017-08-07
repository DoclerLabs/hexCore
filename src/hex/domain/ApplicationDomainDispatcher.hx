package hex.domain;

import hex.core.IApplicationContext;
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
	static var _Instances : Map<IApplicationContext, ApplicationDomainDispatcher> = new Map();
	static var _Instance = new ApplicationDomainDispatcher();

	function new() 
	{
		super( TopLevelDomain.DOMAIN, Dispatcher );
	}
	
	static public function getInstance( context : IApplicationContext ) : ApplicationDomainDispatcher
	{
		if ( context == null )
		{
			return ApplicationDomainDispatcher._Instance;
		}
		else
		{
			var ad : ApplicationDomainDispatcher;
			
			if ( !ApplicationDomainDispatcher._Instances.exists( context ) )
			{
				ad = new ApplicationDomainDispatcher();
				ApplicationDomainDispatcher._Instances.set( context, ad );
			}
			else
			{
				ad = ApplicationDomainDispatcher._Instances.get( context );
			}
			
			return ad;
		}
	}
	
	public static function release() : Void
	{
		ApplicationDomainDispatcher._Instances = new Map();
		ApplicationDomainDispatcher._Instance = new ApplicationDomainDispatcher();
	}
	
	override public function getDomainDispatcher( ?domain : Domain ) : IDispatcher<{}>
	{
		return ( domain != NoDomain.DOMAIN ) ? super.getDomainDispatcher( domain ) : null;
	}
}