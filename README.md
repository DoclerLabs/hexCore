# hexCore
[![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexCore.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexCore)
Independent core elements for building OOP projects and frameworks 

## event system example
```haxe
var messageType = new MessageType( "onInit" );
var dispatcher = new Dispatcher<IMockListener>();

var mockListener = new MockListener();
dispatcher.addListener( mockListener );

var anotherListener = new MockListener();
dispatcher.addHandler( messageType, anotherListener, anotherListener.onMessage )

dispatcher.dispatch( messageType, ["something", 7] );
```

## simple logger example
```haxe
Logger.getInstance().setLevel( LogLevel.DEBUG );
Logger.getInstance().addListener( new TraceLayout() );
Logger.DEBUG( "hola mundo " );
```

## logger example with proxy layout
```haxe
var proxy = new LogProxyLayout();
proxy.addListener( new SimpleBrowserLayout() );

Logger.INFO( "hola mundo ", MyDomain.DOMAIN );
proxy.filter( LogLevel.INFO, MyDomain.DOMAIN );
```