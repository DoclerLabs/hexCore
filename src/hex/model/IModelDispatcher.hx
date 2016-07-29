package hex.model;

/**
 * @author Francis Bourre
 */
typedef IModelDispatcher<ListenerType> = 
{
	#if ( haxe_ver < "3.3" )
	public function new() : Void;
	#end
	
	public function addListener( listener : ListenerType ) : Bool;

	public function removeListener( listener : ListenerType ) : Bool;
}