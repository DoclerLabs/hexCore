package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Tamas Kinsztler
 */
class PointTest
{
    @Test( "Test 'x' and 'y' property passed to constructor" )
    public function testConstructor() : Void
    {
        var point = new Point( 1.0, 2.0 );
        Assert.equals( 1.0, point.x, "x property should be the same passed to constructor" );
        Assert.equals( 2.0, point.y, "y property should be the same passed to constructor" );
    }

    @Test( "Test equals function" )
    public function testComparability() : Void
    {
        var point1 = new Point( 1.0, 2.0 );
        var point2 = new Point( 1.0, 2.0 );
        Assert.isTrue( point1.equals( point2 ), "Point structures should be equals" );
    }
}