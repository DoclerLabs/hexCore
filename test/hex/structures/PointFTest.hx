package hex.structures;

import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class PointFTest
{
	public function new() { }
	
	@Test( "test constructor" )
	public function testConstructor() 
	{
		var p : PointF = { x: 10.0, y: 20.0 };
		Assert.equals( 10.0, p.x, "'x' value should be the same" );
		Assert.equals( 20.0, p.y, "'y' value should be the same" );
		
		p = new PointF( 10.0, 20.0 );
		Assert.equals( 10.0, p.x, "'x' value should be the same" );
		Assert.equals( 20.0, p.y, "'y' value should be the same" );
	}
	
	@Test( "test setters" )
	public function testSetters() 
	{
		var p : PointF = new PointF( 10.0, 20.0 );
		
		p.x = 11.11;
		Assert.equals( 11.11, p.x, "'x' value should be the same" );
		Assert.equals( 20.0, p.y, "'y' value should be the same" );
		
		p.y = 22.22;
		Assert.equals( 11.11, p.x, "'x' value should be the same" );
		Assert.equals( 22.22, p.y, "'y' value should be the same" );
	}
	
	@Test( "test addition operator overloading" )
	public function testAdditionOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		var p2 = p0 + p1;
		
		Assert.equals( p0.x + p1.x, p2.x, "'x' value should be the addition of the both instances 'x' properties" );
		Assert.equals( p0.y + p1.y, p2.y, "'y' value should be the addition of the both instances 'y' properties" );
	}
	
	@Test( "test addition assignment operator overloading" )
	public function testAdditionAssignmentOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		p0 += p1;
		
		Assert.equals( 45.82 + 24.67, p0.x, "'x' value should be the addition of the both instances 'x' properties" );
		Assert.equals( 9.46 + 67.14, p0.y, "'y' value should be the addition of the both instances 'y' properties" );
	}
	
	@Test( "test subtraction operator overloading" )
	public function testSubtractionOperatorOverloading() 
	{
		var p0 = new PointF( 31.56, 71.69 );
		var p1 = new PointF( 91.23, 11.83 );
		
		var p2 = p0 - p1;
		
		Assert.equals( p0.x - p1.x, p2.x, "'x' value should be the subtraction of the both instances 'x' properties" );
		Assert.equals( p0.y - p1.y, p2.y, "'y' value should be the subtraction of the both instances 'y' properties" );
	}
	
	@Test( "test subtraction assignment operator overloading" )
	public function testSubtractionAssignmentOperatorOverloading() 
	{
		var p0 = new PointF( 31.56, 71.69 );
		var p1 = new PointF( 91.23, 11.83 );
		
		p0 -= p1;
		
		Assert.equals( 31.56 - 91.23, p0.x, "'x' value should be the subtraction of the both instances 'x' properties" );
		Assert.equals( 71.69 - 11.83, p0.y, "'y' value should be the subtraction of the both instances 'y' properties" );
	}
	
	@Test( "test multiplication operator overloading" )
	public function testMultiplicationOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		var p2 = p0 * p1;
		
		Assert.equals( p0.x * p1.x, p2.x, "'x' value should be the multiplication of the both instances 'x' properties" );
		Assert.equals( p0.y * p1.y, p2.y, "'y' value should be the multiplication of the both instances 'y' properties" );
	}
	
	@Test( "test multiplication assignment operator overloading" )
	public function testMultiplicationAssignmentOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		p0 *= p1;
		
		Assert.equals( 45.82 * 24.67, p0.x, "'x' value should be the multiplication of the both instances 'x' properties" );
		Assert.equals( 9.46 * 67.14, p0.y, "'y' value should be the multiplication of the both instances 'y' properties" );
	}
	
	@Test( "test division operator overloading" )
	public function testDivisionOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		var p2 = p0 / p1;
		
		Assert.equals( p0.x / p1.x, p2.x, "'x' value should be the division of the both instances 'x' properties" );
		Assert.equals( p0.y / p1.y, p2.y, "'y' value should be the division of the both instances 'y' properties" );
	}
	
	@Test( "test division assignment operator overloading" )
	public function testDivisionAssignmentOperatorOverloading() 
	{
		var p0 = new PointF( 45.82, 9.46 );
		var p1 = new PointF( 24.67, 67.14 );
		
		p0 /= p1;
		
		Assert.equals( 45.82 / 24.67, p0.x, "'x' value should be the division of the both instances 'x' properties" );
		Assert.equals( 9.46 / 67.14, p0.y, "'y' value should be the division of the both instances 'y' properties" );
	}
	
	@Test( "test equal to operator overloading" )
	public function testEqualToOperatorOverloading() 
	{
		var p0 = new PointF( 10.0, 20.0 );
		var p1 = new PointF( 10.0, 20.0 );
		var p2 = new PointF( 10.0, 30.0 );
		var p3 = new PointF( 30.0, 20.0 );

		Assert.isTrue( p0 == p1, "instances equality comparison should return true" );
		Assert.isFalse( p0 == p2, "instances equality comparison should return false" );
		Assert.isFalse( p0 == p3, "instances equality comparison should return false" );
	}
	
	@Test( "test assign operator overloading" )
	public function testAssignOperatorOverloading() 
	{
		var p0 = new PointF( 10.0, 20.0 );
		var p1 = new PointF( 30.0, 40.0 );
		var p3 : PointF;
		p3 = p0;
		
		p0 = p1;
		var p2 = p0;
		
		Assert.isTrue( p0 == p1, "instances equality comparison should return true" );
		Assert.isTrue( p2 == p0, "instances equality comparison should return true" );
	}
	
	@Test( "test Array implicit cast" )
	public function testArrayImplicitCast() 
	{
		var p = new PointF( 10.0, 20.0 );
		var a : Array<Float> = p;
		
		Assert.equals( 10.0, a[ 0 ], "'x' value should be the same" );
		Assert.equals( 20.0, a[ 1 ], "'y' value should be the same" );
	}
	
	@Test( "test Point implicit cast from Size instance" )
	public function testPointImplicitCastFromSizeInstance() 
	{
		var size = new Size( 10.0, 20.0 );
		var p : PointF = size;
		
		Assert.equals( 10.0, p.x, "'x' value should be the same" );
		Assert.equals( 20.0, p.y, "'y' value should be the same" );
	}
	
	@Test( "test Size implicit cast" )
	public function testSizeImplicitCast() 
	{
		var p = new PointF( 10.0, 20.0 );
		var size : Size = p;
		
		Assert.equals( 10.0, size.width, "'x' value should be the same" );
		Assert.equals( 20.0, size.height, "'y' value should be the same" );
	}
}