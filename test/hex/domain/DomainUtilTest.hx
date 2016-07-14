package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class DomainUtilTest
{
	@Test( "Test 'getDomain' method" )
    public function testDomainCreation() : Void
    {
		var domainName = Type.getClassName( Type.getClass( this ) ) + "_testDomainCreation";
		
		var domain = DomainUtil.getDomain( domainName, Domain );
		Assert.isNotNull( domain, "getDomain function should create a domain if doesn't exist" );
		Assert.isInstanceOf( domain, Domain, "getDomain should return a domain instance of the requested type" );
		Assert.equals( domainName, domain.getName(), "domain's name should be the same that was requested" );
	}
	
    @Test( "Test 'getDomain' twice" )
    public function testGetDomainTwice() : Void
    {
		var domainName = Type.getClassName( Type.getClass( this ) ) + "_testGetDomainTwice";
		
        var domain = DomainUtil.getDomain( domainName, DefaultDomain );
        var anotherDomainWithTheSameName = Domain.getDomain( domainName );
		
        Assert.equals( domain, anotherDomainWithTheSameName, "getDomain should return the same domain" );
    }
}
