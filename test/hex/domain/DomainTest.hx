package hex.domain;

import hex.domain.Domain;
import hex.error.NullPointerException;
import hex.error.IllegalArgumentException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class DomainTest
{
    @test( "Test 'name' property passed to constructor" )
    public function testConstructor() : Void
    {
        var domain : Domain = new Domain( "testConstructor" );
        Assert.assertEquals( "testConstructor", domain.getName(), "'name' property should be the same passed to constructor" );
    }

    @test( "Test null 'name' value passed to constructor" )
    public function testConstructorNullException() : Void
    {
        Assert.assertConstructorCallThrows( NullPointerException, Domain, [], "" );
    }

    @test( "Test using twice the same 'name' value" )
    public function testConstructorWithNameValues() : Void
    {
        var domain : Domain = new Domain( "testConstructorWithNameValues" );
        Assert.assertConstructorCallThrows( IllegalArgumentException, Domain, ["testConstructorWithNameValues"], "" );
    }
}
