package hex.util;

import hex.error.IllegalArgumentException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class ClassUtilTest
{
	public static inline var STATIC_REF : String = "static_ref";
	
	@Test( "Test getClassReference" )
    public function testGetClassReference() : Void
    {
		Assert.equals( ClassUtilTest, ClassUtil.getClassReference( "hex.util.ClassUtilTest" ), "'getClassReference' should return the right class reference" );
		Assert.methodCallThrows( IllegalArgumentException, ClassUtil, ClassUtil.getClassReference, ["dummy.unavailable.Class"], "'getClassReference' should throw IllegalArgumentException" );
	}
	
	@Test( "Test getStaticReference" )
    public function testGetStaticReference() : Void
    {
		Assert.equals( "static_ref", ClassUtil.getStaticReference( "hex.util.ClassUtilTest.STATIC_REF" ), "'getStaticReference' should return the right static property" );
		Assert.methodCallThrows( IllegalArgumentException, ClassUtil, ClassUtil.getStaticReference, ["hex.util.ClassUtilTest.UnavailableStaticRef"], "'getStaticReference' should throw IllegalArgumentException" );
	}
	
}