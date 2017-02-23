package hex.domain;

import hex.log.Stringifier;
import hex.error.NullPointerException;
import hex.error.IllegalArgumentException;

/**
 * ...
 * @author Francis Bourre
 */
@:final
class Domain
{
    var _domainName : String;
    static var _domainNames = new Map<String, Domain>();

    public function new( domainName : String )
    {
        if ( domainName == null )
        {
            throw new NullPointerException( "Domain's name can't be null" );
        }
        else if ( Domain._domainNames.exists( domainName ) )
        {
            throw new IllegalArgumentException( "Domain has already been registered with name '" + domainName + "'" );
        }
        else
        {
            Domain._domainNames.set( domainName, this );
            this._domainName = domainName;
        }
    }

    public function getName() : String
    {
		return this._domainName;
    }
	
	public static function getDomain( domainName : String ) : Domain
	{
		if ( !Domain._domainNames.exists( domainName ) )
        {
            return null;
        }
		else
		{
			return Domain._domainNames.get( domainName );
		}
	}

    public function toString() : String
    {
        return Stringifier.stringify( this ) + " with name '" + this.getName() + "'";
    }
}
