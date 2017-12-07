package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class DefaultDomainTest
{
	public function new() { }
	
    @Test( "Test if DefaultDomain static variable exists" )
    public function testIfDefaultDomainStaticVariableExists() : Void
    {
        Assert.equals( "DefaultDomain", DefaultDomain.DOMAIN.getName(), "'DefaultDomain.DOMAIN' static variable name should be 'DefaultDomain'" );
    }
	
	@Test( "Test if DefaultDomain.DOMAIN is an instance of DefaultDomain" )
    public function testDefaultDomainStaticVariableType() : Void
    {
        Assert.isInstanceOf( DefaultDomain.DOMAIN, Domain, "domain should be an instance of 'DefaultDomain'" );
    }
}
