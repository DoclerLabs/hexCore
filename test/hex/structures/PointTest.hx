package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class PointTest
{
	@Test( "test constructor" )
	public function testConstructor() 
	{
		var p : Point = { x: 10, y: 20 };
		Assert.equals( 10, p.x, "'x' value should be the same" );
		Assert.equals( 20, p.y, "'y' value should be the same" );
		
		p = new Point( 10, 20 );
		Assert.equals( 10, p.x, "'x' value should be the same" );
		Assert.equals( 20, p.y, "'y' value should be the same" );
	}
	
	@Test( "test setters" )
	public function testSetters() 
	{
		var p : Point = new Point( 10, 20 );
		
		p.x = 11;
		Assert.equals( 11, p.x, "'x' value should be the same" );
		Assert.equals( 20, p.y, "'y' value should be the same" );
		
		p.y = 22;
		Assert.equals( 11, p.x, "'x' value should be the same" );
		Assert.equals( 22, p.y, "'y' value should be the same" );
	}
	
	@Test( "test addition operator overloading" )
	public function testAdditionOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		var p2 = p0 + p1;
		
		Assert.equals( p0.x + p1.x, p2.x, "'x' value should be the addition of the both instances 'x' properties" );
		Assert.equals( p0.y + p1.y, p2.y, "'y' value should be the addition of the both instances 'y' properties" );
	}
	
	@Test( "test addition assignment operator overloading" )
	public function testAdditionAssignmentOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		p0 += p1;
		
		Assert.equals( 45 + 24, p0.x, "'x' value should be the addition of the both instances 'x' properties" );
		Assert.equals( 9 + 67, p0.y, "'y' value should be the addition of the both instances 'y' properties" );
	}
	
	@Test( "test subtraction operator overloading" )
	public function testSubtractionOperatorOverloading() 
	{
		var p0 = new Point( 31, 71 );
		var p1 = new Point( 91, 11 );
		
		var p2 = p0 - p1;
		
		Assert.equals( p0.x - p1.x, p2.x, "'x' value should be the subtraction of the both instances 'x' properties" );
		Assert.equals( p0.y - p1.y, p2.y, "'y' value should be the subtraction of the both instances 'y' properties" );
	}
	
	@Test( "test subtraction assignment operator overloading" )
	public function testSubtractionAssignmentOperatorOverloading() 
	{
		var p0 = new Point( 31, 71 );
		var p1 = new Point( 91, 11 );
		
		p0 -= p1;
		
		Assert.equals( 31 - 91, p0.x, "'x' value should be the subtraction of the both instances 'x' properties" );
		Assert.equals( 71 - 11, p0.y, "'y' value should be the subtraction of the both instances 'y' properties" );
	}
	
	@Test( "test multiplication operator overloading" )
	public function testMultiplicationOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		var p2 = p0 * p1;
		
		Assert.equals( p0.x * p1.x, p2.x, "'x' value should be the multiplication of the both instances 'x' properties" );
		Assert.equals( p0.y * p1.y, p2.y, "'y' value should be the multiplication of the both instances 'y' properties" );
	}
	
	@Test( "test multiplication assignment operator overloading" )
	public function testMultiplicationAssignmentOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		p0 *= p1;
		
		Assert.equals( 45 * 24, p0.x, "'x' value should be the multiplication of the both instances 'x' properties" );
		Assert.equals( 9 * 67, p0.y, "'y' value should be the multiplication of the both instances 'y' properties" );
	}
	
	@Test( "test division operator overloading" )
	public function testDivisionOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		var p2 = p0 / p1;
		
		Assert.equals( Std.int( p0.x / p1.x ), p2.x, "'x' value should be the division of the both instances 'x' properties" );
		Assert.equals( Std.int( p0.y / p1.y ), p2.y, "'y' value should be the division of the both instances 'y' properties" );
	}
	
	@Test( "test division assignment operator overloading" )
	public function testDivisionAssignmentOperatorOverloading() 
	{
		var p0 = new Point( 45, 9 );
		var p1 = new Point( 24, 67 );
		
		p0 /= p1;
		
		Assert.equals( Std.int( 45 / 24 ), p0.x, "'x' value should be the division of the both instances 'x' properties" );
		Assert.equals( Std.int( 9 / 67 ), p0.y, "'y' value should be the division of the both instances 'y' properties" );
	}
	
	@Test( "test equal to operator overloading" )
	public function testEqualToOperatorOverloading() 
	{
		var p0 = new Point( 10, 20 );
		var p1 = new Point( 10, 20 );
		var p2 = new Point( 10, 30 );
		var p3 = new Point( 30, 20 );

		Assert.isTrue( p0 == p1, "instances equality comparison should return true" );
		Assert.isFalse( p0 == p2, "instances equality comparison should return false" );
		Assert.isFalse( p0 == p3, "instances equality comparison should return false" );
	}
	
	@Test( "test assign operator overloading" )
	public function testAssignOperatorOverloading() 
	{
		var p0 = new Point( 10, 20 );
		var p1 = new Point( 30, 40 );
		var p3 : Point;
		p3 = p0;
		
		p0 = p1;
		var p2 = p0;
		
		Assert.isTrue( p0 == p1, "instances equality comparison should return true" );
		Assert.isTrue( p2 == p0, "instances equality comparison should return true" );
	}
	
	@Test( "test Array implicit cast" )
	public function testArrayImplicitCast() 
	{
		var p = new Point( 10, 20 );
		var a : Array<Int> = p;
		
		Assert.equals( 10, a[ 0 ], "'x' value should be the same" );
		Assert.equals( 20, a[ 1 ], "'y' value should be the same" );
	}
	
	@Test( "test Point implicit cast from Size instance" )
	public function testPointImplicitCastFromSizeInstance() 
	{
		var size = new Size( 10, 20 );
		var p : Point = size;
		
		Assert.equals( 10, p.x, "'x' value should be the same" );
		Assert.equals( 20, p.y, "'y' value should be the same" );
	}
	
	@Test( "test Size implicit cast" )
	public function testSizeImplicitCast() 
	{
		var p = new Point( 10, 20 );
		var size : Size = p;
		
		Assert.equals( 10, size.width, "'x' value should be the same" );
		Assert.equals( 20, size.height, "'y' value should be the same" );
	}
}