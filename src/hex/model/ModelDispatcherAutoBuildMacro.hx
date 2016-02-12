package hex.model;

import haxe.macro.Context;
import haxe.macro.Expr.Field;

/**
 * ...
 * @author Francis Bourre
 */
class ModelDispatcherAutoBuildMacro
{
	function new()
	{
		
	}
	
	macro static public function build() : Array<Field> 
	{
		var fields = Context.getBuildFields();
		
		for ( field in fields ) 
		{
			switch ( field.kind ) 
			{
				case FFun( func ) :
				
					var methodName  = field.name;
					if ( methodName == "new" ) continue;

					var args = [for (arg in func.args) macro $i { arg.name } ];
					
					func.expr = macro 
					{
						for ( listener in this._listeners ) listener.$methodName( $a{args} );
					};
					
				default : 
			}
		}

		return fields;
	}
}