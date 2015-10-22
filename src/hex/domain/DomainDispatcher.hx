package hex.domain;

import hex.domain.Domain;
import hex.event.IEvent;
import hex.event.IEventListener;
import hex.event.IEventDispatcher;
import hex.event.EventDispatcher;

/**
 * ...
 * @author Francis Bourre
 */
class DomainDispatcher<ListenerType:IEventListener, EventType:IEvent>
{
    private var _domains 			: Map<Domain, IEventDispatcher<ListenerType, EventType>>;
    private var _defaultDomain 	    : Domain;
    private var _dispatcherClass 	: Class<IEventDispatcher<ListenerType, EventType>>;

    public function new( ?defaultDomain : Domain, ?dispatcherClass : Class<IEventDispatcher<ListenerType, EventType>> )
    {
        this.clear();
        this.setDefaultDomain( defaultDomain );
        this.setDispatcherClass( dispatcherClass );
    }

    public function setDispatcherClass( ?dispatcherClass : Class<IEventDispatcher<ListenerType, EventType>> ) : Void
	{
        this._dispatcherClass = dispatcherClass != null ? dispatcherClass : EventDispatcher;

	}

    public function getDefaultDispatcher() : IEventDispatcher<ListenerType, EventType>
    {
        return this._domains.get( this._defaultDomain );
    }

    public function getDefaultDomain() : Domain
    {
        return this._defaultDomain;
    }

    public function setDefaultDomain( domain : Domain = null ) : Void
    {
        this._defaultDomain = ( domain == null ) ? DefaultDomain.DOMAIN : domain;
        this.getDomainDispatcher( this.getDefaultDomain() );
    }

    public function clear() : Void
    {
        this._domains = new Map<Domain, IEventDispatcher<ListenerType, EventType>>();
        var domain : Domain = this.getDefaultDomain();
        if ( domain != null )
        {
            this.getDomainDispatcher( domain );
        }
    }

    public function isRegistered( listener : ListenerType, eventType : String, domain : Domain ) : Bool
    {
        return this.hasChannelDispatcher( domain ) ? this.getDomainDispatcher( domain ).isRegistered( listener, eventType ) : false;
    }

    public function hasChannelDispatcher( ?domain : Domain ) : Bool
    {
        return domain == null ? this._domains.exists( this._defaultDomain ) : this._domains.exists( domain );
    }

    public function getDomainDispatcher( ?domain : Domain ) : IEventDispatcher<ListenerType, EventType>
    {
        if ( this.hasChannelDispatcher( domain ) )
        {
            return domain == null ? this._domains.get( this._defaultDomain ) : this._domains.get( domain );

        } else
        {
            var dispatcher : IEventDispatcher<ListenerType, EventType> = new EventDispatcher<ListenerType, EventType>();
            this._domains.set( domain, dispatcher );
            return dispatcher;
        }
    }

    public function releaseDomainDispatcher( domain : Domain ) : Bool
    {
        if ( this.hasChannelDispatcher( domain ) )
        {
            this._domains.get( domain ).removeAllListeners();
            this._domains.remove( domain );
            return true;
        }
        else
        {
            return false;
        }
    }

    public function addListener( listener : ListenerType, ?domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).addListener( listener );
    }

    public function removeListener( listener : ListenerType, ?domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).removeListener( listener );
    }

    public function addEventListener( eventType : String, callback : EventType->Void, domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).addEventListener( eventType, callback );
    }

    public function removeEventListener( eventType : String, callback : EventType->Void, domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).removeEventListener( eventType, callback );
    }

    public function dispatchEvent( event : EventType, domain : Domain ) : Void
    {
        this.getDomainDispatcher( domain ).dispatchEvent( event );
    }

    public function removeAllListeners() : Void
    {
        var iterator = this._domains.keys();
        while( iterator.hasNext() )
        {
            this._domains.get( iterator.next() ).removeAllListeners();
        }

        this.clear();
    }
}
