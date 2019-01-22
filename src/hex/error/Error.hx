package hex.error;

import haxe.PosInfos;
using tink.CoreApi;

@IgnoreCover
class IllegalArgumentException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class IllegalStateException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class NoSuchElementException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class NullPointerException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class PrivateConstructorException extends Error
{
    public function new ( ?message : String = "This class can't be instantiated.", ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class UnsupportedOperationException extends Error
{
    public function new ( message : String, ?posInfos : PosInfos ) super( code, message, pos );
}

@IgnoreCover
class VirtualMethodException extends Error
{
    public function new ( ?message : String = 'this method must be overridden', ?posInfos : PosInfos ) super( code, message, pos );
}