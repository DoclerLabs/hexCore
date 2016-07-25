package hex.model;

#if ( haxe_ver >= "3.3" )
import haxe.Constraints.Constructible;
#end

/**
 * @author Francis Bourre
 */
typedef IModelDispatcher<ListenerType> = 
{
	#if ( haxe_ver >= "3.3" )
	> Constructible<Void->Void>,
	#else
	public function new() : Void;
	#end
	
	public function addListener( listener : ListenerType ) : Bool;

	public function removeListener( listener : ListenerType ) : Bool;
}