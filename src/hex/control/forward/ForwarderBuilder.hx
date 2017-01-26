package hex.control.forward;

import haxe.macro.Context;
import haxe.macro.Expr;
import hex.error.PrivateConstructorException;

/**
 * ...
 * @author Francis Bourre
 */
class ForwarderBuilder
{
	public static inline var ForwardAnnotation = "Forward";
	
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

		for ( f in fields )
		{
			switch( f.kind )
			{ 
				//TODO handle multiple forward
				//TODO make unit tests
				//TODO exclude constructor
				case FFun( func ):
					
					var meta = f.meta.filter( function ( m ) { return m.name == ForwarderBuilder.ForwardAnnotation; } );
					var isForwarder = meta.length > 0;
					if ( isForwarder ) 
					{
						var methodList = ForwarderBuilder._getMethodList( meta )[ 0 ];
						
						//
						var expressions = [ macro @:mergeBlock {} ];
						
						var methArgs = [ for ( arg in func.args ) macro $i { arg.name } ];
						var methodName = f.name;
						
						var body = macro @:mergeBlock
						{
							$p{ methodList }( $a{ methArgs } ); 
						};
						
						//
						expressions.push( body );
						expressions.push( func.expr );
						var finalExpression = macro $b { expressions };
						func.expr = finalExpression;
						
						f.meta = [];//TODO remove
					}
					
				case _:
			}
			
		}
		
		return fields;
	}
	
	static function _getMethodList( meta : Metadata ) : Array<Array<String>>
	{
		var a = [];
		for ( m in meta )
		{
			var params = m.params;
			for ( p in params )
			{
				var e = switch( p.expr )
				{
					case EConst( c ):
						switch( c )
						{
							case CIdent( s ):
								[ s.toString() ];
								
							case _: null;
						}
					
					case EField( e, field ):
						switch( e.expr ) 
						{ 
							case EConst( CIdent( s ) ):
								[ s.toString(), field ];
								
							case _: null;
						}
						
					case _: null;
				}
				
				a.push( e );
			}
		}
		return a;
	}
}