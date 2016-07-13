package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class DomainUtilTest
{
    @Test( "Test getDomain function" )
    public function testGetDomain() : Void
    {
        var domain = DomainUtil.getDomain( "testDomainUtil", DefaultDomain );
        var expectedDomain = Domain.getDomain( "testDomainUtil" );
        Assert.equals( expectedDomain, domain, "getDomain function should create a domain if it not exists with specified name" );

        var domain : Domain = DomainUtil.getDomain( "testDomainUtil", DefaultDomain );
        Assert.equals( expectedDomain, domain, "getDomain function should return the existing domain with specified name" );
    }
}
