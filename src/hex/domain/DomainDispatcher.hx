package hex.domain;

import hex.domain.IDomainDispatcher;
import hex.event.Dispatcher;
import hex.event.IDispatcher;
import hex.event.MessageType;

/**
 * ...
 * @author Francis Bourre
 */
class DomainDispatcher<ListenerType:{}> implements IDomainDispatcher<ListenerType>
{
    var _domains 			: Map<Domain, IDispatcher<ListenerType>>;
    var _defaultDomain 	    : Domain;
    var _dispatcherClass 	: Class<IDispatcher<ListenerType>>;

    public function new( ?defaultDomain : Domain, ?dispatcherClass : Class<IDispatcher<ListenerType>> )
    {
        this.clear();
        this.setDefaultDomain( defaultDomain );
        this.setDispatcherClass( dispatcherClass );
    }

    public function setDispatcherClass( ?dispatcherClass : Class<IDispatcher<ListenerType>> ) : Void
	{
        this._dispatcherClass = dispatcherClass != null ? dispatcherClass : Dispatcher;
	}

    public function getDefaultDispatcher() : IDispatcher<ListenerType>
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
        this._domains = new Map<Domain, IDispatcher<ListenerType>>();
        var domain : Domain = this.getDefaultDomain();
        if ( domain != null )
        {
            this.getDomainDispatcher( domain );
        }
    }

    public function isRegistered( listener : ListenerType, messageType : MessageType, domain : Domain ) : Bool
    {
        return this.hasChannelDispatcher( domain ) ? this.getDomainDispatcher( domain ).isRegistered( listener, messageType ) : false;
    }

    public function hasChannelDispatcher( ?domain : Domain ) : Bool
    {
        return domain == null ? this._domains.exists( this._defaultDomain ) : this._domains.exists( domain );
    }

    public function getDomainDispatcher( ?domain : Domain ) : IDispatcher<ListenerType>
    {
        if ( this.hasChannelDispatcher( domain ) )
        {
            return domain == null ? this._domains.get( this._defaultDomain ) : this._domains.get( domain );

        } else
        {
            var dispatcher = new Dispatcher<ListenerType>();
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

    public function addHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T, domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).addHandler( messageType, scope, callback );
    }

    public function removeHandler<T:haxe.Constraints.Function>( messageType : MessageType, scope : Dynamic, callback : T, domain : Domain ) : Bool
    {
        return this.getDomainDispatcher( domain ).removeHandler( messageType, scope, callback );
    }

    public function dispatch( messageType : MessageType, ?domain : Domain, ?data : Array<Dynamic> ) : Void
    {
        this.getDomainDispatcher( domain ).dispatch( messageType, data );
		if ( domain != this._defaultDomain && domain != null )
		{
			this.getDefaultDispatcher().dispatch( messageType, data );
		}
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
