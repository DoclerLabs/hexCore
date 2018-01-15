package hex.service;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class ServiceConfigurationTest
{
	public function new() { }
	
    @Test( "Test 'timeout' property passed to constructor" )
    public function testConstructor() : Void
    {
        var serviceConfiguration = new ServiceConfiguration( 3000 );
        Assert.equals( 3000, serviceConfiguration.serviceTimeout, "'timeout' property should be the same passed to constructor" );
    }

    @Test( "Test no property passed to constructor" )
    public function testConstructorNoProperty() : Void
    {
        var serviceConfiguration = new ServiceConfiguration();
        Assert.equals( 5000, serviceConfiguration.serviceTimeout, "'timeout' property should be the default one" );
    }
}