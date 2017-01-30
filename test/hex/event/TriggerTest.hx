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
		var model 				= new MockModel<Bool>();
		var intMockDriver 		= new IntMockDriver();
		var stringMockDriver 	= new StringMockDriver();
		var genericMockDriver 	= new GenericMockDriver();
		
		model.intOutput.connect( intMockDriver );
		model.stringOutput.connect( stringMockDriver );
		model.genericOutput.connect( genericMockDriver );
		
		model.changeAllValues( 3, "test", this );
		Assert.equals( 1, intMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 1, stringMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 1, genericMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 3, intMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( "test", stringMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( this, genericMockDriver.callbackParam, "callback parameter should be the same" );
		
		model.stringOutput.disconnectAll();
		model.genericOutput.disconnectAll();
		model.changeAllValues( 4, "another test", this );
		Assert.equals( 2, intMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 1, stringMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 1, genericMockDriver.callbackCallCount, "callback should have been called once" );
		Assert.equals( 4, intMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( "test", stringMockDriver.callbackParam, "callback parameter should be the same" );
		Assert.equals( this, genericMockDriver.callbackParam, "callback parameter should be the same" );
    }
}

private class MockModel<T> implements ITriggerOwner
{
    public var intOutput( default, never ) : ITrigger<IIntConnection>;
	
    public var stringOutput( default, never )  : ITrigger<IStringConnection>;
	
	public var genericOutput( default, never )  : ITrigger<GenericConnection<TriggerTest>>;

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
	public var callbackCallCount : Int = 0;
	public var callbackParam 	: Int = 0;
	
	public function new()
	{
		
	}
	
    public function onChangeIntValue( i : Int ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = i;
	}
}

private class StringMockDriver implements IStringConnection
{
	public var callbackCallCount : Int 		= 0;
	public var callbackParam 	: String 	= null;
	
	public function new()
	{
		
	}
	
    public function onChangeStringValue( s : String ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = s;
	}
}

private class GenericMockDriver implements GenericConnection<TriggerTest>
{
	public var callbackCallCount : Int 			= 0;
	public var callbackParam 	: TriggerTest 	= null;
	
	public function new()
	{
		
	}
	
    public function onChangeValue( o : TriggerTest ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = o;
	}
}