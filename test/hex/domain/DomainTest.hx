package hex.domain;

import hex.domain.Domain;
import hex.error.IllegalArgumentException;
import hex.error.NullPointerException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class DomainTest
{
    @Test( "Test 'name' property passed to constructor" )
    public function testConstructor() : Void
    {
        var domain = Type.createInstance( Domain, [ "testConstructor" ] );
        Assert.equals( "testConstructor", domain.getName(), "'name' property should be the same passed to constructor" );
    }

	#if !php
    @Test( "Test null 'name' value passed to constructor" )
    public function testConstructorNullException() : Void
    {
        Assert.constructorCallThrows( NullPointerException, Domain, [], "" );
    }
    #end

    @Test( "Test using twice the same 'name' value" )
    public function testConstructorWithNameValues() : Void
    {
        var domain = Type.createInstance( Domain, [ "testConstructorWithNameValues" ] );
        Assert.constructorCallThrows( IllegalArgumentException, Domain, ["testConstructorWithNameValues"], "" );
    }

    @Test( "Test getName function" )
	public function testGetName() : Void
	{
    	var domain = Type.createInstance( Domain, [ "testGetName" ] );
        Assert.equals( "testGetName", domain.getName(), "'getName' method should return correct domain's name" );
	}

    @Test( "Test getDomain function" )
	public function testGetDomain() : Void
	{
    	var newDomain = Type.createInstance( Domain, [ "testGetDomain" ] );
        var domain = Domain.getDomain( "testGetDomain" );
        Assert.equals( newDomain, domain, "getDomain method should return the same instance if it already exists" );

        domain = Domain.getDomain( "nonExistingDomain" );
        Assert.equals( null, domain, "'getDomain' method should return null if the requested domain doesn't exist" );
	}

    @Test( "Test toString function" )
	public function testToString() : Void
	{
        var domain = Type.createInstance( Domain, [ "testToString" ] );
        var expectedString = "hex.domain.Domain with name 'testToString'";
        Assert.equals( expectedString, domain.toString(), "toString method should return expected string value" );
	}
}
