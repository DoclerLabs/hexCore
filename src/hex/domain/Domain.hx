package hex.domain;

import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.util.Stringifier;

/**
 * ...
 * @author Francis Bourre
 */
@:final
class Domain
{
    var _name 	: String;
	var _parent : Domain;
	
    static var _domains = new Map<String, Domain>();

    function new( domainName : String )
    {
        if ( domainName == null )
        {
            throw new NullPointerException( "Domain's name can't be null" );
        }
        else if ( Domain._domains.exists( domainName ) )
        {
            throw new IllegalArgumentException( "Domain has already been registered with name '" + domainName + "'" );
        }
        else
        {
            Domain._domains.set( domainName, this );
            this._name = domainName;
        }
    }

    public function getName() : String
    {
		return this._name;
    }
	
	public function getParent() : Domain
    {
		return this._parent;
    }
	
	static public function getDomain( domainName : String ) : Domain
	{
		var domain = null;
		
		if ( Domain._domains.exists( domainName ) )
		{
			domain = Domain._domains.get( domainName );
		}
		else
		{
			domain = new Domain( domainName );
			Domain._domains.set( domainName, domain );
		}
		
		Domain._reparent();
		return domain;
	}

    public function toString() : String
    {
        return Stringifier.stringify( this ) + " with name '" + this.getName() + "'";
    }
	
	static function _reparent() : Void
	{
		var domains = Domain._domains;
		
		for ( key in domains.keys() )
		{
			var domain = domains.get( key );
			if ( key != null && key != '' )
			{
				var i = key.lastIndexOf( '.' );
				if ( i > 0 )
				{
					key = key.substring( 0, i );
					var parent = Domain._getDomain( key );
					if ( parent == null )
					{
						parent = TopLevelDomain.DOMAIN;
					}
					domain._parent = parent;
				}
				else
				{
					domain._parent = TopLevelDomain.DOMAIN;
				}
			}
		}
	}
	
	static public function _getDomain( name : String ) : Domain 
	{
		var domains = Domain._domains;
		
		var domain = domains.get( name );
		if ( domain != null )
		{
			return domain;
		}
		
		var substr = name;
		while ( ( substr = Domain._getSubName( substr ) ) != null )
		{
			domain = domains.get( substr );
			if ( domain != null )
			{
				return domain;
			}
		}
		
		return TopLevelDomain.DOMAIN;
	}
	
	/**
	 * 
	 * @param	name
	 * @return
	 */
	static function _getSubName( name : String ) : String
	{
		if ( name == null || name == '' ) 
		{
			return null;
		}
		var i = name.lastIndexOf( '.' );
		return i > 0 ? name.substring( 0, i ) : '';
	}
}
