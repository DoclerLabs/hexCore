package hex.model;

/**
 * @author Francis Bourre
 */
typedef IModelDispatcher<ListenerType> = 
{
	public function new() : Void;
	
	public function addListener( listener : ListenerType ) : Bool;

	public function removeListener( listener : ListenerType ) : Bool;
}