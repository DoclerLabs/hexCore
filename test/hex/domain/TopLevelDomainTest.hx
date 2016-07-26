package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class TopLevelDomainTest
{
	@Test( "Test if 'TopLevelDomain' static variable exists" )
    public function testIfTopLevelDomainStaticVariableExists() : Void
    {
        Assert.equals( "TopLevelDomain", TopLevelDomain.DOMAIN.getName(), "'TopLevelDomain.DOMAIN' static variable name should be 'TopLevelDomain'" );
    }
	
	@Test( "Test if TopLevelDomain.DOMAIN is an instance of TopLevelDomain" )
    public function testTopLevelDomainStaticVariableType() : Void
    {
        Assert.isInstanceOf( TopLevelDomain.DOMAIN, TopLevelDomain, "domain should be an instance of 'TopLevelDomain'" );
    }
}
