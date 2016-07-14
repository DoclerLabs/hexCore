package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class NoDomainTest
{
	@Test( "Test if NoDomain static variable exists" )
    public function testDefaultDomainStaticVariableExists() : Void
    {
        Assert.equals( "NoDomain", NoDomain.DOMAIN.getName(), "NoDomain static variable name should be 'NoDomain'" );
    }
	
	@Test( "Test if NoDomain.DOMAIN is an instance of NoDomain" )
    public function testDefaultDomainStaticVariableType() : Void
    {
        Assert.isInstanceOf( NoDomain.DOMAIN, NoDomain, "domain should be an instance of 'NoDomain'" );
    }
}
