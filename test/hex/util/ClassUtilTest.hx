package hex.util;

import hex.unittest.assertion.Assert;

using hex.error.Error;

/**
 * ...
 * @author Francis Bourre
 */
class ClassUtilTest
{
	public static var STATIC_REF : String = "static_ref";
	public static inline var STATIC_INLINE_REF : String = "static_inline_ref";

	@Test( "test constructor is private" ) 
	public function testPrivateConstructor() : Void
	{
		Assert.constructorIsPrivate( ClassUtil );
	}
	
	@Test( "Test getClassReference" )
    public function testGetClassReference() : Void
    {
		Assert.equals( ClassUtilTest, ClassUtil.getClassReference( "hex.util.ClassUtilTest" ), "'getClassReference' should return the right class reference" );
		Assert.methodCallThrows( IllegalArgumentException, ClassUtil, ClassUtil.getClassReference, ["dummy.unavailable.Class"], "'getClassReference' should throw IllegalArgumentException" );
	}
	
	@Test( "Test getStaticVariableReference" )
    public function testGetStaticVariableReference() : Void
    {
		Assert.equals( "static_ref", ClassUtil.getStaticVariableReference( "hex.util.ClassUtilTest.STATIC_REF" ), "'getStaticReference' should return the right static property" );
		//Assert.equals( "static_inline_ref", ClassUtil.getStaticVariableReference( "hex.util.ClassUtilTest.STATIC_INLINE_REF" ), "'getStaticReference' should return the right static inline property" );
		Assert.methodCallThrows( IllegalArgumentException, ClassUtil, ClassUtil.getStaticVariableReference, ["hex.util.ClassUtilTest.UnavailableStaticRef"], "'getStaticReference' should throw IllegalArgumentException" );
	}

	@Test( "Test getClassNameFromStaticReference" )
    public function testGetClassNameFromStaticReference() : Void
    {
		Assert.equals( "hex.util.ClassUtilTest", ClassUtil.getClassNameFromStaticReference( "hex.util.ClassUtilTest.STATIC_REF" ), "'getClassNameFromStaticReference' should return the right static property" );
		Assert.equals( "hex.util.ClassUtilTest", ClassUtil.getClassNameFromStaticReference( "hex.util.ClassUtilTest.STATIC_INLINE_REF" ), "'getClassNameFromStaticReference' should return the right static inline property" );
	}
	
	@Test( "Test getStaticVariableNameFromStaticReference" )
    public function testGetStaticVariableNameFromStaticReference() : Void
    {
		Assert.equals( "STATIC_REF", ClassUtil.getStaticVariableNameFromStaticReference( "hex.util.ClassUtilTest.STATIC_REF" ), "'getStaticVariableNameFromStaticReference' should return the right static property" );
		Assert.equals( "STATIC_INLINE_REF", ClassUtil.getStaticVariableNameFromStaticReference( "hex.util.ClassUtilTest.STATIC_INLINE_REF" ), "'getStaticVariableNameFromStaticReference' should return the right static inline 	property" );
	}
	
	@Test( "Test getClassName" )
    public function testGetClassName() : Void
    {
		Assert.equals( "hex.util.ClassUtilTest", ClassUtil.getClassName( this ), "'getClassName' should return the right class name" );
	}
}