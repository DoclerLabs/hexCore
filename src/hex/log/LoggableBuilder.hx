package hex.log;

import haxe.macro.Context;
import haxe.macro.Expr;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class LoggableBuilder
{
	public static inline var DebugAnnotation 	= "Debug";
	public static inline var InfoAnnotation 	= "Info";
	public static inline var WarnAnnotation 	= "Warn";
	public static inline var ErrorAnnotation 	= "Error";
	public static inline var FatalAnnotation 	= "Fatal";
	
	/** @private */
    function new()
    {
        throw new PrivateConstructorException( "This class can't be instantiated." );
    }
	
	macro static public function build() : Array<Field> 
	{
		var fields = Context.getBuildFields();
		
		if ( Context.getLocalClass().get().isInterface )
		{
			return fields;
		}
		
		var className = Context.getLocalClass().get().module;
		var loggerAnnotations = [ DebugAnnotation, InfoAnnotation, WarnAnnotation, ErrorAnnotation, FatalAnnotation ];

		for ( f in fields )
		{
			switch( f.kind )
			{ 
				//TODO exclude constructor
				//TODO add class metadata that adds the injected logger property 
				//TODO make unit tests
				case FFun( func ):
					
					var meta = f.meta.filter( function ( m ) { return loggerAnnotations.indexOf( m.name ) != -1; } );
					var isLoggable = meta.length > 0;
					if ( isLoggable ) 
					{
						#if debug
						var logSetting =  LoggableBuilder._getParameters( meta );
						
						var expressions = [ macro @:mergeBlock {} ];
						var methArgs = [ for ( arg in func.args ) macro @:pos(f.pos) $i { arg.name } ];
						
						//
						var message = logSetting.message;
						if ( message == null )
						{
							message = className + '::' + f.name;
						}
						var debugArgs = [ macro @:pos(f.pos) $v { message } ].concat( methArgs );
						var methodName = meta[ 0 ].name.toLowerCase();
		
						var body = macro @:pos(f.pos) @:mergeBlock
						{
							#if debug
							logger.$methodName( [$a { debugArgs } ] );
							#end
						};

						expressions.push( body );
						expressions.push( func.expr );
						func.expr = macro @:pos(f.pos) $b { expressions };
						#end
						
						//f.meta = [ meta[ 0 ] ];//TODO Check everything is fine
						f.meta = [];//TODO remove
					}
					
				case _:
			}
			
		}
		
		return fields;
	}
	
	static function _getParameters( meta : Metadata ) : LogSetting
	{
		for ( m in meta )
		{
			var params = m.params;
			if ( params.length > 1 )
			{
				Context.warning( "Only one argument is allowed", m.pos );
			}
			
			for ( p in params )
			{
				var e = switch( p.expr )
				{
					case EObjectDecl( o ):
						
						var logSetting = new LogSetting();
						
						for ( f in o )
						{
							switch( f.field )
							{
								case "msg":
									switch( f.expr.expr )
									{
										case EConst( CString( s ) ):
											logSetting.message = s;

										case _:
									}
									
								case "arg":
									switch( f.expr.expr )
									{
										case EArrayDecl( a ):
											logSetting.arg = [];
											for ( id in a )
											{
												switch( id.expr )
												{
													case EConst( CIdent( i ) ):
														logSetting.arg.push( i.toString() );
														
													case EField( _.expr => EConst( CIdent( i ) ), f ):

														if ( i.toString() != "this" )
														{
															Context.error( "'" + i + "." + f + "' is not allowed", id.pos );
														}
														logSetting.arg.push( "this." + f );
														
													case _:
												}
											}
											
										case _:
									}
									
								case _:
							}
						}

						
					
						return logSetting;
						
					case _:
				}
				
				//
			}
		}
		return new LogSetting();
	}
}

private class LogSetting
{
	public function new()
	{
		
	}
	
	public var message 	: String;
	public var arg 		: Array<String>;
}