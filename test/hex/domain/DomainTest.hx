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
		var domainName = Type.getClassName( Type.getClass( this ) ) + "_testGetName";
    	var domain = Domain.getDomain( domainName );
		
        Assert.equals( domainName, domain.getName(), "`getName` method should return correct domain's name" );
	}
	
	@Test( "Test `getParent` function" )
	public function testGetParent() : Void
	{
		var domainName = 'parent.' + Type.getClassName( Type.getClass( this ) ) + '_testGetParent';
    	var domain = Domain.getDomain( domainName );
		
        Assert.equals( TopLevelDomain.DOMAIN, domain.getParent(), "`getParent` method should return root parent" );
		
		var childDomain = Domain.getDomain( domainName + '.child' );
		Assert.notEquals( domain, childDomain, "domains should not be the same" );
		Assert.equals( domain, childDomain.getParent(), "`getParent` method should return parent" );
		
		var parentDomain = Domain.getDomain( 'parent' );
		Assert.notEquals( parentDomain, domain, "domains should not be the same" );
		Assert.notEquals( parentDomain, childDomain, "domains should not be the same" );
		Assert.equals( parentDomain, domain.getParent(), "`getParent` method should return root parent" );
	}

    @Test( "Test getDomain function" )
	public function testGetDomain() : Void
	{
    	var newDomain = Type.createInstance( Domain, [ "testGetDomain" ] );
        var domain = Domain.getDomain( "testGetDomain" );
        Assert.equals( newDomain, domain, "getDomain method should return the same instance if it already exists" );

        domain = Domain.getDomain( "nonExistingDomain" );
        Assert.isInstanceOf( domain, Domain, "'getDomain' method should return new instance if it doesn't exist" );
        Assert.equals( "nonExistingDomain", domain.getName(), "'getDomain' method should return new instance if it doesn't exist" );
	}

    @Test( "Test toString function" )
	public function testToString() : Void
	{
        var domain = Type.createInstance( Domain, [ "testToString" ] );
        var expectedString = "hex.domain.Domain with name 'testToString'";
        Assert.equals( expectedString, domain.toString(), "toString method should return expected string value" );
	}
	
	@Test( "Test `getDomain` method" )
    public function testDomainCreation() : Void
    {
		var domainName = Type.getClassName( Type.getClass( this ) ) + "_testDomainCreation";
		
		var domain = Domain.getDomain( domainName );
		Assert.isNotNull( domain, "`getDomain` function should create a domain if doesn't exist" );
		Assert.isInstanceOf( domain, Domain, "`getDomain` should return a domain instance of the requested type" );
		Assert.equals( domainName, domain.getName(), "domain's name should be the same that was requested" );
	}
	
    @Test( "Test `getDomain` twice" )
    public function testGetDomainTwice() : Void
    {
		var domainName = Type.getClassName( Type.getClass( this ) ) + "_testGetDomainTwice";
		
        var domain = Domain.getDomain( domainName );
        var anotherDomainWithTheSameName = Domain.getDomain( domainName );
		
        Assert.equals( domain, anotherDomainWithTheSameName, "getDomain should return the same domain" );
    }
}
