# hexCore
[![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexCore.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexCore)
Independent core elements for building OOP projects and frameworks 

*Find more information about hexMachina on [hexmachina.org](http://hexmachina.org/)*

## Dispatcher example
```haxe
//This event system is the easiest one to use

var messageType = new MessageType( "onInit" );
var dispatcher = new Dispatcher<IMockListener>();

var mockListener = new MockListener();
dispatcher.addListener( mockListener );

var anotherListener = new MockListener();
dispatcher.addHandler( messageType, anotherListener, anotherListener.onMessage )
dispatcher.dispatch( messageType, ["something", 7] );
```

## EventDispatcher example
```haxe
//This event system is the stricter than the previous one

var dispatcher = new EventDispatcher<IEventListener, BasicEvent>();
dispatcher.addListener( new MockListener() );
dispatcher.dispatchEvent( new BasicEvent( "onEvent", this._dispatcher ) );
```

## Simple logger example
```haxe
Logger.getInstance().setLevel( LogLevel.DEBUG );
Logger.getInstance().addListener( new TraceLayout() );
Logger.DEBUG( "hola mundo " );
```

## Logger example with proxy layout
```haxe
var proxy = new LogProxyLayout();
proxy.addListener( new SimpleBrowserLayout() );

Logger.INFO( "hola mundo ", MyDomain.DOMAIN );
proxy.filter( LogLevel.INFO, MyDomain.DOMAIN );
```

## Locator example
```haxe
class MyLocator extends Locator<String, ISomething>
{
	public function new( builderFactory : BuilderFactory )
	{
		super();
	}
	
	override function _dispatchRegisterEvent( key : String, element : ISomething ) : Void 
	{
		this._dispatcher.dispatch( LocatorMessage.REGISTER, [ key, element ] );
	}
	
	override function _dispatchUnregisterEvent( key : String ) : Void 
	{
		this._dispatcher.dispatch( LocatorMessage.UNREGISTER, [ key ] );
	}
}
```
## Run tests

Add hexUnit dependency as a git submodule:

```git submodule add https://github.com/DoclerLabs/hexUnit.git hexunit```

Run commands:
- Run all tests: ```npm test```
- Run Flash tests: ```npm run test-js```
- Run JS tests: ```npm run test-flash```
- Run PHP tests: ```npm run test-php```