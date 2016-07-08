package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class SizeTest
{
    @Test( "Test 'width' and 'height' property passed to constructor" )
    public function testConstructor() : Void
    {
	    var size = new Size( 1.0, 2.0 );

	    Assert.equals( 1.0, size.width, "width property should be the same passed to constructor" );
	    Assert.equals( 2.0, size.height, "height property should be the same passed to constructor" );
	}
 
	@Test( "Test equals function" )
	public function testEquals() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
    	var size2 = new Size( 1.0, 2.0 );

    	Assert.isTrue( size1.equals( size2 ), "Size structures should be equals" );
	}

    @Test( "Test setSize function" )
	public function testSetSize() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = new Size( 3.0, 4.0 );
        size1.setSize( size2 );

    	Assert.equals( size1.width, size2.width, "width property should be change to passed Size object width" );
        Assert.equals( size1.height, size2.height, "height property should be change to passed Size object height" );

        size1 = new Size( 1.0, 2.0 );
        size1.setSize( null );

        Assert.equals( size1.width, 1.0, "passing null as Size should not change to Size object width" );
        Assert.equals( size1.height, 2.0, "passing null as Size should not change to Size object height" );
	}

    @Test( "Test setSizeWH function" )
	public function testSetSizeWH() : Void
	{
    	var size = new Size( 1.0, 2.0 );
        size.setSizeWH( 3.0, 4.0 );

    	Assert.equals( size.width, 3.0, "width property should be change to passed param width" );
        Assert.equals( size.height, 4.0, "height property should be change to passed param height" );

        size = new Size( 1.0, 2.0 );
        size.setSizeWH( Math.NaN, Math.NaN );

        Assert.equals( size.width, 1.0, "passing NaN as width param should not change to Size object width" );
        Assert.equals( size.height, 2.0, "passing NaN as height param should not change to Size object height" );
	}

    @Test( "Test clone function" )
	public function testClone() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = size1.clone();

    	Assert.equals( size1.width, size2.width, "first object width property should be the same as second object width" );
        Assert.equals( size1.height, size2.height, "first object height property should be the same as second object height" );
	}

    @Test( "Test scale function" )
	public function testScale() : Void
	{
    	var size = new Size( 1.0, 2.0 );
        var result = size.scale( 5.0 );

    	Assert.equals( result.width, 5.0, "scaled Size object width should be multiplied with factor param" );
        Assert.equals( result.height, 10.0, "scaled Size object height should be multiplied with factor param" );

        size = new Size( 1.0, 2.0 );
        result = size.scale( Math.NaN );

        Assert.equals( result.width, 1.0, "scaled Size object width should be not changed with NaN factor param" );
        Assert.equals( result.height, 2.0, "scaled Size object height should be not changed with NaN factor param" );
	}

    @Test( "Test substract function" )
	public function testSubstract() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = new Size( 1.0, 1.0 );
        var result = size1.substract( size2 );

    	Assert.equals( result.width, 0.0, "second object width should be subtracted from first object width" );
        Assert.equals( result.height, 1.0, "second object height should be subtracted from first object height" );

        result = size1.substract( null );

        Assert.equals( result.width, 1.0, "null subtracted from Size object should not change Size object width" );
        Assert.equals( result.height, 2.0, "null subtracted from Size object should not change Size object height" );
	}

    @Test( "Test add function" )
	public function testAdd() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = new Size( 1.0, 1.0 );
        var result = size1.add( size2 );

    	Assert.equals( result.width, 2.0, "second object width should be added to first object width" );
        Assert.equals( result.height, 3.0, "second object height should be added to first object height" );

        result = size1.add( null );

        Assert.equals( result.width, 1.0, "null added to Size object should not change Size object width" );
        Assert.equals( result.height, 2.0, "null added to Size object should not change Size object height" );
	}

    @Test( "Test toPoint function" )
	public function testToPoint() : Void
	{
    	var size = new Size( 1.0, 2.0 );
    	var point = size.toPoint();

        Assert.isInstanceOf( point, Point, "toPoint function should convert Size type to Point type" );
    	Assert.equals( size.width, point.x, "Size width property should be the same as Point x property" );
        Assert.equals( size.height, point.y, "Size height property should be the same as Point y property" );
	}
}