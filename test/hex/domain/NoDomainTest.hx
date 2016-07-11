package hex.domain;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class NoDomainTest
{
    @Test( "Test if NoDomain static variable exist" )
    public function testNoDomain() : Void
    {
        var noDomain = NoDomain.DOMAIN;
        Assert.equals( noDomain.getName(), "NoDomain", "NoDomain static variable name should be 'NoDomain'" );
    }
}
