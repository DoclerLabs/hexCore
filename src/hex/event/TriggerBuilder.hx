package hex.event;

#if macro
import haxe.macro.ComplexTypeTools;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type.ClassField;
import haxe.macro.Type.ClassType;
import haxe.macro.Type.Ref;
import haxe.macro.Type.TypeParameter;
import haxe.macro.TypeTools;
import hex.error.PrivateConstructorException;
import hex.event.ITrigger;
import hex.util.MacroUtil;

using haxe.macro.Context;
using haxe.macro.Tools;

/**
 * ...
 * @author Francis Bourre
 */
@:final 
class TriggerBuilder
{
	static var _cache 	: Map<String, TypeDefinition> 	= new Map();
	static var _ID 		: UInt 							= 0;
	
	/** @private */
    function new()
    {
        throw new PrivateConstructorException();
    }
	
	static function _isOutput( f ) : Bool
	{
		return switch ( f.kind )
		{
			case FProp( get, set, TPath( p ), e ):
				MacroUtil.getClassFullQualifiedName( p ) == Type.getClassName( ITrigger );
				
			default:
				false;
		}
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
			var isOutput = TriggerBuilder._isOutput( f );
			if ( isOutput ) 
			{
				switch( f.kind )
				{ 
					case FVar( t, e ):
						
						Context.error( "'" + f.name + "' property is not public with read access only.\n Use 'public var " +
							f.name + " ( default, never )'", f.pos );

					case FProp( get, set, t, e ):
						
						if ( get != "default" || set != "never" )
						{
							Context.error( "'" + f.name + "' property is not public with read access only.\n Use 'public var " +
							f.name + " ( default, never )'", f.pos );
						}
						
						f.kind = _getKind( f, get, set );
						
					case _:
				}
			}
		}
		
        return fields;
    }
	
	static function _getKind( f: Field, get, set )
	{
		var triggerDefinition 	= TriggerBuilder._getTriggerDefinition( f );
		
		var classVO : ClassVO = null;
		if ( triggerDefinition.tPath != null )
		{
			classVO = TriggerBuilder._buildClassVOFromTPath( triggerDefinition.tPath );
		}
		else
		{
			classVO = TriggerBuilder._buildClassVOFromTFunction( triggerDefinition.tFun );
		}

		var typePath 			= MacroUtil.getTypePath( classVO.fullClassName );
		var complexType 		= TypeTools.toComplexType( Context.getType( classVO.fullClassName ) );
		
		return FProp( get, set, complexType, { expr: MacroUtil.instantiate( typePath ), pos: f.pos } );
	}
	
	static function _getTriggerDefinition( f: Field )
	{
		switch ( f.kind )
		{
			case FProp( _, _, TPath( p ), e ):

				for ( param in p.params )
				{
					switch( param )
					{
						case TPType( tp ) :

							switch( tp )
							{
								case TPath( p ):
									switch ( Context.getType( p.pack.concat( [ p.name ] ).join( '.' ) ) )
									{
										case TInst( t, pp ):
											return { tPath: { name: t.get().name, triggerParamType: tp, typePath: p }, tFun: null };
											
										case _:
									}
								
									case TFunction( args, ret ):
										return { tPath: null, tFun: { args: args, ret: ret, triggerParamType: tp } };
								case _:
							}
							
						case _:
						
					}
				}

			case _:
		}

		return null;
	}
	
	static function _getClassSkeleton( className : String, listenerType : Null<ComplexType> ) : TypeDefinition
	{
		return macro class $className
		{ 
			var _inputs : Array<$listenerType>;
	
			public function new() 
			{
				this._inputs = [];
			}

			public function connect( input : $listenerType ) : Bool
			{
				if ( this._inputs.indexOf( input ) == -1 )
				{
					this._inputs.push( input );
					return true;
				}
				else
				{
					return false;
				}
			}

			public function disconnect( input : $listenerType ) : Bool
			{
				var index : Int = this._inputs.indexOf( input );
				
				if ( index > -1 )
				{
					this._inputs.splice( index, 1 );
					return true;
				}
				else
				{
					return false;
				}
			}
			
			public function disconnectAll() : Void
			{
				this._inputs = [];
			}
		};
	}
	
	static function _buildClassVOFromTFunction( triggerDefinition : { args: Array<ComplexType>, ret: ComplexType, triggerParamType : Null<ComplexType> } ) : ClassVO
	{
		var getPack = function( className : String ) : { pack: Array<String>, className: String }
		{
			var pack = className.split( "." );
			var className = pack[ pack.length -1 ];
			pack.splice( pack.length - 1, 1 );
		
			return { pack: pack, className: className };
		}

		var isVoid = function(ct:ComplexType):Bool
		{
			return ct.getParameters()[0].name == (macro :Void).getParameters()[0].name;
		}

		var l = triggerDefinition.args.length;
		if (triggerDefinition.args.length == 1 && isVoid(triggerDefinition.args[0]))
		{
			l = 0;
		}

		var args = [];
		for ( i in 0...l ) 
		{
			var t = triggerDefinition.args[ i ];
			switch( t )
			{
				case TPath( p ):
					var ttype = t.toType().toString().split('<')[0];
					var tPack = getPack( ttype );
					//do the dirty job of setting the right pack for each argument if the developer forgets to set it.
					p.pack = tPack.pack;
					
				case _:
			}
			args.push( { name: 'arg' + i, type: t, opt: false } );
		}
		
		var className 	= '__Trigger_Class__' + (TriggerBuilder._ID++);
		var dispatcherClass : TypeDefinition = null;

		//build class
		dispatcherClass = TriggerBuilder._getClassSkeleton( className, triggerDefinition.triggerParamType );

		var newField : Field = 
		{
			meta: null,
			name: 'trigger',
			pos: Context.currentPos(),
			kind: null,
			access: [ APublic ]
		}

		var methArgs = [ for ( arg in args ) macro $i { arg.name } ];
		var body = 
		macro 
		{
			for ( input in this._inputs ) input( $a{ methArgs } );
		};
		
		newField.kind = FFun( 
			{
				args: args,
				ret: triggerDefinition.ret,
				expr: body
			}
		);
		
		dispatcherClass.fields.push( newField );
		dispatcherClass.pack = [ 'hex', 'event' ];

		switch( dispatcherClass.kind )
		{
			case TDClass( superClass, interfaces, isInterface ):
				//interfaces.push( typePath );
				interfaces.push( MacroUtil.getTypePath( Type.getClassName( ITrigger ), [ TPType( triggerDefinition.triggerParamType ) ] ) );
				
			case _:
		}

		Context.defineType( dispatcherClass );
		return { name: dispatcherClass.name, pack: dispatcherClass.pack, fullClassName: dispatcherClass.pack.join( '.' ) + '.' + dispatcherClass.name };
	}
	
	static function _buildClassVOFromTPath( triggerDefinition : { name: String, typePath : TypePath, triggerParamType : Null<ComplexType> } ) : ClassVO
	{
		var className 	= '__Trigger_Class_For__' + triggerDefinition.name;
		var dispatcherClass : TypeDefinition = null;
		
		if ( !TriggerBuilder._cache.exists( className ) )
		{
			dispatcherClass = TriggerBuilder._getClassSkeleton( className, triggerDefinition.triggerParamType );

			var newFields = dispatcherClass.fields;
			switch( ComplexTypeTools.toType( triggerDefinition.triggerParamType ) )
			{
				case TInst( _.get() => cls, params ):

					var fields : Array<ClassField> = cls.fields.get();

					for ( field in fields )
					{
						switch( field.kind )
						{
							case FMethod( k ):
								
								var fieldType 					= field.type;
								var ret : ComplexType 			= null;
								var args : Array<FunctionArg> 	= [];
							
								switch( fieldType )
								{
									case TFun( a, r ):
										
										ret = r.toComplexType();

										if ( a.length > 0 )
										{
											args = a.map( function( arg )
											{
												switch( arg.t )
												{
													case TInst( t, p ):
														var i = _getIndex( t, cls.params );
														if ( i != -1 )
														{
															return cast { name: arg.name, type: params[i].toComplexType(), opt: arg.opt };
														}

													case _:
												}
												return cast { name: arg.name, type: arg.t.toComplexType(), opt: arg.opt };
											} );
										}
									
									case _:
								}

								var newField : Field = 
								{
									meta: field.meta.get(),
									name: field.name,
									pos: field.pos,
									kind: null,
									access: [ APublic ]
								}

								var methodName  = field.name;
								var methArgs = [ for ( arg in args ) macro $i { arg.name } ];
								var body = 
								macro 
								{
									for ( input in this._inputs ) input.$methodName( $a{ methArgs } );
								};
								
								
								newField.kind = FFun( 
									{
										args: args,
										ret: ret,
										expr: body
									}
								);
								
								newFields.push( newField );
								
							case _:
						}
					}

					case _:
			}
			
			var typePath 	: TypePath;
			var pack 		: Array<String>;
			
			switch( triggerDefinition.triggerParamType )
			{
				case TPath( p ):
					var t = Context.getType( p.pack.concat( [ p.name ] ).join( '.' ) );

					switch ( t )
					{
						case TInst( t, p ):
							var ct = t.get();
							pack = ct.pack.copy();
							
						case _:
					}

					typePath = p;

					
				case _:
			}

			dispatcherClass.pack = pack;

			switch( dispatcherClass.kind )
			{
				case TDClass( superClass, interfaces, isInterface ):
					interfaces.push( typePath );
					//interfaces.push( interfaceName.typePath );
					interfaces.push( MacroUtil.getTypePath( Type.getClassName( ITrigger ), [ TPType( triggerDefinition.triggerParamType ) ] ) );
					
				case _:
			}
			
			Context.defineType( dispatcherClass );
			TriggerBuilder._cache.set( className, dispatcherClass );
		}
		else
		{
			dispatcherClass = TriggerBuilder._cache.get( className );
		}
		
		return { name: dispatcherClass.name, pack: dispatcherClass.pack, fullClassName: dispatcherClass.pack.join( '.' ) + '.' + dispatcherClass.name };
	}

	static function _getIndex( t:Ref<ClassType>, params : Array<TypeParameter> ): Int
	{
		var l = params.length;
		for ( i in 0...l )
		{
			var param = params[ i ];

			switch( param.t )
			{
				case TInst( tt, pp ):

					if ( "" + tt == "" + t ) 
					{
						return i;
					}
				case _:
			}
		}
		return -1;
	}
}
#end

typedef ClassVO =
{
	name: String, 
	pack: Array<String>,
	fullClassName: String
}