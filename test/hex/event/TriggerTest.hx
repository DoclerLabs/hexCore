package hex.event;

import hex.event.MockTypedef;
import hex.data.IParser;
import hex.structures.Size;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class TriggerTest
{
	@Test( "test trigger instantiation and callbacks" )
    public function testTriggerInstantiationAndCallbacks() : Void
    {
		var model 				= new MockModel<Bool>();
		var intMockDriver 		= new IntMockDriver();
		var stringMockDriver 	= new StringMockDriver();
		var genericMockDriver 	= new GenericMockDriver();
		
		model.intOutput.connect( intMockDriver );
		model.stringOutput.connect( stringMockDriver );
		model.genericOutput.connect( genericMockDriver );
		
		var callbackResult;
		model.callbacks.connect( function ( s : String, i : Int ) callbackResult = { s: s, i: i } );
		
		var colorResult = MockColor.Red;
		model.colorCallbacks.connect( function ( color : MockColor ) colorResult = color );
		
		var parserResult = '';
		model.triggerParser.connect( function ( parser : IParser<String> ) parserResult = parser.parse( 'test' ) );
		
		var parserResult2;
		model.triggerParser2.connect( function ( parser : IParser<MockTypedef> ) parserResult2 = parser.parse( 'test' ) );
		
		var voidTriggered = false;
		model.voidTrigger.connect( function() voidTriggered = true );
		
		var optionals = [];
		model.optionalTrigger.connect( function( ?str : String ) optionals.push(str) );
		
		model.changeAllValues( 3, "test", this );
		Assert.equals( 1, intMockDriver.callbackCallCount );
		Assert.equals( 1, stringMockDriver.callbackCallCount );
		Assert.equals( 1, genericMockDriver.callbackCallCount );
		Assert.equals( 3, intMockDriver.callbackParam );
		Assert.equals( "test", stringMockDriver.callbackParam );
		Assert.equals( this, genericMockDriver.callbackParam );
		Assert.equals( "test", callbackResult.s );
		Assert.equals( 3, callbackResult.i );
		Assert.equals( MockColor.Blue, colorResult );
		Assert.equals('test was parsed', parserResult );
		Assert.equals('test', parserResult2.name );
		Assert.isTrue( voidTriggered );
		Assert.deepEquals([null, "test"], optionals);
		
		model.stringOutput.disconnectAll();
		model.genericOutput.disconnectAll();
		model.callbacks.disconnectAll();
		model.voidTrigger.disconnectAll();
		model.optionalTrigger.disconnectAll();

		voidTriggered = false;
		
		model.changeAllValues( 4, "another test", this );
		Assert.equals( 2, intMockDriver.callbackCallCount );
		Assert.equals( 1, stringMockDriver.callbackCallCount );
		Assert.equals( 1, genericMockDriver.callbackCallCount );
		Assert.equals( 4, intMockDriver.callbackParam );
		Assert.equals( "test", stringMockDriver.callbackParam );
		Assert.equals( this, genericMockDriver.callbackParam );
		Assert.equals( "test", callbackResult.s );
		Assert.equals( 3, callbackResult.i );
		Assert.isFalse( voidTriggered );
    }
	
	@Test( "test trigger instantiation and callbacks" )
    public function testTriggerWithDisconnect() : Void
    {
		var model 					= new MockModel<Bool>();
		
		var intMockDriverRemover 	= new IntMockDriverRemover( model.intOutput );
		var intMockDriver 			= new IntMockDriver();
		
		model.intOutput.connect( intMockDriverRemover );
		model.intOutput.connect( intMockDriver );
		
		model.changeAllValues( 3, "test", this );

		Assert.equals( 1, intMockDriver.callbackCallCount );
		Assert.equals( 1, intMockDriverRemover.callbackCallCount );
		
		model.changeAllValues( 4, "hello", this );
		Assert.equals( 2, intMockDriver.callbackCallCount );
		Assert.equals( 1, intMockDriverRemover.callbackCallCount );
	}
}

private class MockModel<T> implements ITriggerOwner
{
    public var intOutput( default, never ) : ITrigger<IIntConnection>;
	
    public var stringOutput( default, never )  : ITrigger<IStringConnection>;
	
	public var genericOutput( default, never )  : ITrigger<GenericConnection<TriggerTest>>;
	
	public var callbacks( default, never )  : ITrigger<String->Int->Void>;
	
	public var colorCallbacks( default, never ) : ITrigger<MockColor->Void>;
	
	public var triggerParser( default, never ) : ITrigger<IParser<String>->Void>;
	
	public var triggerParser2( default, never ) : ITrigger<IParser<MockTypedef>->Void>;
	
	public var voidTrigger( default, never ) : ITrigger<Void->Void>;
	
	public var optionalTrigger( default, never ):ITrigger<?String->Void>;

    public function new(){}
	
	public function changeAllValues( i : Int, s : String, o : TriggerTest ) : Void
    {
        this.intOutput.onChangeIntValue( i );
        this.stringOutput.onChangeStringValue( s );
		this.genericOutput.onChangeValue( o );
		this.callbacks.trigger( s, i );
		this.colorCallbacks.trigger( MockColor.Blue );
		this.triggerParser.trigger( new MockParser() );
		this.triggerParser2.trigger( new MockParser2() );
		this.voidTrigger.trigger();
		this.optionalTrigger.trigger();
		this.optionalTrigger.trigger(s);
    }
}

private class MockParser implements IParser<String>
{
	public function new() {}
	public function parse( serializedContent : Dynamic, target : Dynamic = null ) : String
	{
		return serializedContent + " was parsed";
	}
}

private class MockParser2 implements IParser<MockTypedef>
{
	public function new() {}
	public function parse( serializedContent : Dynamic, target : Dynamic = null ) : MockTypedef
	{
		return {name:serializedContent};
	}
}

private class IntMockDriver implements IIntConnection
{
	public var callbackCallCount : Int = 0;
	public var callbackParam 	: Int = 0;
	
	public function new(){}
	
    public function onChangeIntValue( i : Int ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = i;
	}
}

private class IntMockDriverRemover implements IIntConnection
{
	public var callbackCallCount : Int = 0;
	public var callbackParam 	: Int = 0;
	
	var _triggerToRemoveFrom : ITrigger<IIntConnection>;
	
	public function new( triggerToRemoveFrom ) { this._triggerToRemoveFrom = triggerToRemoveFrom;  }
	
    public function onChangeIntValue( i : Int ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = i;
		this._triggerToRemoveFrom.disconnect( this );
	}
}

private class StringMockDriver implements IStringConnection
{
	public var callbackCallCount : Int 		= 0;
	public var callbackParam 	: String 	= null;
	
	public function new(){}
	
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
	
	public function new(){}
	
    public function onChangeValue( o : TriggerTest ) : Void
	{
		this.callbackCallCount++;
		this.callbackParam = o;
	}
}