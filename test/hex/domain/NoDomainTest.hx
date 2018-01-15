package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class NoDomainTest
{
	public function new() { }
	
	@Test( "Test if NoDomain static variable exists" )
    public function testIfNoDomainStaticVariableExists() : Void
    {
        Assert.equals( "NoDomain", NoDomain.DOMAIN.getName(), "'NoDomain.DOMAIN' static variable name should be 'NoDomain'" );
    }
	
	@Test( "Test if NoDomain.DOMAIN is an instance of NoDomain" )
    public function testNoDomainStaticVariableType() : Void
    {
        Assert.isInstanceOf( NoDomain.DOMAIN, Domain, "domain should be an instance of 'NoDomain'" );
    }
}
