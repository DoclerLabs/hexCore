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
        var expectedString = "hex.domain.DefaultDomain with name 'testDomainUtil'";
        Assert.equals( domain, expectedString, "getDomain function should create a domain if it not exists with specified name" );

        var domain = DomainUtil.getDomain( "testDomainUtil", null );
        var expectedString = "hex.domain.DefaultDomain with name 'testDomainUtil'";
        Assert.equals( domain, expectedString, "getDomain function should return the existing domain with specified name" );
    }
}
