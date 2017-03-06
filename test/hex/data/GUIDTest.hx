package hex.data;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class GUIDTest
{
	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( GUID );
	}
	
    @Test( "Test randomIntegerWithinRange function" )
    public function testRandomIntegerWithinRange() : Void
    {
        var random = GUID.randomIntegerWithinRange( 1, 1000 );
        Assert.isTrue( random >= 1, "random integer should be greater than or equal range minimum" );
        Assert.isTrue( random <= 1000, "random integer should be less than or equal range maximum" );

        random = GUID.randomIntegerWithinRange( -2000, -1000 );
        Assert.isTrue( random >= -2000, "random negative integer should be greater than or equal range minimum" );
        Assert.isTrue( random <= -1000, "random negative integer should be less than or equal range maximum" );

        random = GUID.randomIntegerWithinRange( 0, 0 );
        Assert.equals( 0, random, "random integer should equal range minimum/maximum if minimum equals maximum" );
    }

    @Test( "Test createRandomIdentifier function" )
    public function testCreateRandomIdentifier() : Void
    {
        var random = GUID.createRandomIdentifier( 100 );
        Assert.equals( 100, random.length, "function should generate a string with specified length" );

        random = GUID.createRandomIdentifier( 0 );
        Assert.equals( 0, random.length, "function should not generate a string with 0 length" );

        random = GUID.createRandomIdentifier( 10, 0 );
        Assert.equals( 10, random.length, "function should generate a string with lowered radix" );
        Assert.equals( -1, random.split( "" ).indexOf( "1" ), "function should generate string with lower subset if radix has lower value" );
    }

    @Test( "Test uuid function" )
    public function testUuid() : Void
    {
        var uuid = GUID.uuid();
        Assert.equals( 32, uuid.length, "uuid length should be always 32" );
        Assert.equals( 4, Std.parseInt( uuid.charAt( 12 ) ), "uuid version should be 4" );

        var variants = ['8', '9', 'A', 'B'];
        Assert.isTrue( variants.indexOf( uuid.charAt( 16 ) ) != -1, "uuid variant should be 8, 9, A or B" );
    }
}