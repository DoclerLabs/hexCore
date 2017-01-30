package hex.event;

import hex.structures.Size;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class TriggerTest
{
	@Test( "test output instantiation and callbacks" )
    public function testOutputInstantiationAndCallbacks() : Void
    {
		var model 				= new MockModel();
		var intMockDriver 		= new IntMockDriver();
		var stringMockDriver 	= new StringMockDriver();
		var genericMockDriver 	= new GenericMockDriver();
		
		Assert.isInstanceOf( model.size, Size, "property that is not annotated should kept its initial type and value" );
		
		model.intOutput.connect( intMockDriver );
		model.stringOutput.connect( stringMockDriver );
		model.genericOutput.connect( genericMockDriver );
		
		IntMockDriver.reset();
		StringMockDriver.reset();
		GenericMockDriver.reset();
		
		model.changeAllValues( 3, "test", this );
		Assert.equals( 1, IntMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 1, StringMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 3, IntMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( "test", StringMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( this, GenericMockDriver.callbackParam, "callback parameter should be the same" );
    }
}

private class MockModel implements ITriggerOwner
{
    public var intOutput( default, never ) : ITrigger<IIntConnection>;
	
    public var stringOutput( default, never )  : ITrigger<IStringConnection>;
	
	public var genericOutput( default, never )  : ITrigger<GenericConnection<TriggerTest>>;
	
	public var size : Size = new Size( 10, 20 );

    public function new()
    {
        //
    }
	
	public function changeAllValues( i : Int, s : String, o : TriggerTest ) : Void
    {
        this.intOutput.onChangeIntValue( i );
        this.stringOutput.onChangeStringValue( s );
		this.genericOutput.onChangeValue( o );
    }
}

private class IntMockDriver implements IIntConnection
{
	public static var callbackCallCount : Int = 0;
	public static var callbackParam 	: Int = 0;
	
	public function new()
	{
		
	}
	
	static public function reset() : Void
	{
		IntMockDriver.callbackCallCount = 0;
		IntMockDriver.callbackParam = 0;
	}
	
    public function onChangeIntValue( i : Int ) : Void
	{
		IntMockDriver.callbackCallCount++;
		IntMockDriver.callbackParam = i;
	}
}

private class StringMockDriver implements IStringConnection
{
	public static var callbackCallCount : Int 		= 0;
	public static var callbackParam 	: String 	= null;
	
	public function new()
	{
		
	}
	
	static public function reset() : Void
	{
		StringMockDriver.callbackCallCount = 0;
		StringMockDriver.callbackParam = null;
	}
	
    public function onChangeStringValue( s : String ) : Void
	{
		StringMockDriver.callbackCallCount++;
		StringMockDriver.callbackParam = s;
	}
}

private class GenericMockDriver implements GenericConnection<TriggerTest>
{
	public static var callbackCallCount : Int 			= 0;
	public static var callbackParam 	: TriggerTest 	= null;
	
	public function new()
	{
		
	}
	
	static public function reset() : Void
	{
		GenericMockDriver.callbackCallCount = 0;
		GenericMockDriver.callbackParam = null;
	}
	
    public function onChangeValue( o : TriggerTest ) : Void
	{
		GenericMockDriver.callbackCallCount++;
		GenericMockDriver.callbackParam = o;
	}
}