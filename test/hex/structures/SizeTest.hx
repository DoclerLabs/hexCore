package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class SizeTest
{
	public function new() { }
	
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

    	Assert.equals( size2.width, size1.width, "width property should be change to passed Size object width" );
        Assert.equals( size2.height, size1.height, "height property should be change to passed Size object height" );

        size1 = new Size( 1.0, 2.0 );
        size1.setSize( null );

        Assert.equals( 1.0, size1.width, "passing null as Size should not change to Size object width" );
        Assert.equals( 2.0, size1.height, "passing null as Size should not change to Size object height" );
	}

    @Test( "Test setSizeWH function" )
	public function testSetSizeWH() : Void
	{
    	var size = new Size( 1.0, 2.0 );
        size.setSizeWH( 3.0, 4.0 );

    	Assert.equals( 3.0, size.width, "width property should be change to passed param width" );
        Assert.equals( 4.0, size.height, "height property should be change to passed param height" );

        size = new Size( 1.0, 2.0 );
        size.setSizeWH( Math.NaN, Math.NaN );

        Assert.equals( 1.0, size.width, "passing NaN as width param should not change to Size object width" );
        Assert.equals( 2.0, size.height, "passing NaN as height param should not change to Size object height" );
	}

    @Test( "Test clone function" )
	public function testClone() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = size1.clone();

    	Assert.equals( size2.width, size1.width, "first object width property should be the same as second object width" );
        Assert.equals( size2.height, size1.height, "first object height property should be the same as second object height" );
	}

    @Test( "Test scale function" )
	public function testScale() : Void
	{
    	var size = new Size( 1.0, 2.0 );
        var result = size.scale( 5.0 );

    	Assert.equals( 5.0, result.width, "scaled Size object width should be multiplied with factor param" );
        Assert.equals( 10.0, result.height, "scaled Size object height should be multiplied with factor param" );

        size = new Size( 1.0, 2.0 );
        result = size.scale( Math.NaN );

        Assert.equals( 1.0, result.width, "scaled Size object width should be not changed with NaN factor param" );
        Assert.equals( 2.0, result.height, "scaled Size object height should be not changed with NaN factor param" );
	}

    @Test( "Test substract function" )
	public function testSubstract() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = new Size( 1.0, 1.0 );
        var result = size1.substract( size2 );

    	Assert.equals( 0.0, result.width, "second object width should be subtracted from first object width" );
        Assert.equals( 1.0, result.height, "second object height should be subtracted from first object height" );

        result = size1.substract( null );

        Assert.equals( 1.0, result.width, "null subtracted from Size object should not change Size object width" );
        Assert.equals( 2.0, result.height, "null subtracted from Size object should not change Size object height" );
	}

    @Test( "Test add function" )
	public function testAdd() : Void
	{
    	var size1 = new Size( 1.0, 2.0 );
        var size2 = new Size( 1.0, 1.0 );
        var result = size1.add( size2 );

    	Assert.equals( 2.0, result.width, "second object width should be added to first object width" );
        Assert.equals( 3.0, result.height, "second object height should be added to first object height" );

        result = size1.add( null );

        Assert.equals( 1.0, result.width, "null added to Size object should not change Size object width" );
        Assert.equals( 2.0, result.height, "null added to Size object should not change Size object height" );
	}

    @Test( "Test toPoint function" )
	public function testToPoint() : Void
	{
    	var size = new Size( 1.0, 2.0 );
    	var point = size.toPoint();

    	Assert.equals( point.x, size.width, "Size width property should be the same as Point x property" );
        Assert.equals( point.y, size.height, "Size height property should be the same as Point y property" );
	}
}