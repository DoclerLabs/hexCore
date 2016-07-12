package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class DefaultDomainTest
{
    @Test( "Test if DefaultDomain static variable exist" )
    public function testDefaultDomain() : Void
    {
        var defaultDomain = DefaultDomain.DOMAIN;
        Assert.equals( "DefaultDomain", defaultDomain.getName(), "DefaultDomain static variable name should be 'DefaultDomain'" );
    }
}
