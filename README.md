# hexCore
[![TravisCI Build Status](https://travis-ci.org/DoclerLabs/hexCore.svg?branch=master)](https://travis-ci.org/DoclerLabs/hexCore)
Independent core elements for building OOP projects and frameworks 

## event system example
```haxe
var messageType : MessageType = new MessageType( "onInit" );
var dispatcher : Dispatcher<IMockListener> = new Dispatcher<IMockListener>();

var mockListener : MockListener = new MockListener();
dispatcher.addListener( mockListener );

var anotherListener : MockListener = new MockListener();
dispatcher.addHandler( messageType, anotherListener, anotherListener.onMessage )

dispatcher.dispatch( messageType, ["something", 7] );
```