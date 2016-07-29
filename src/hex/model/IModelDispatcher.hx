package hex.model;

/**
 * @author Francis Bourre
 */
typedef IModelDispatcher<ListenerType> = 
{
	public function addListener( listener : ListenerType ) : Bool;

	public function removeListener( listener : ListenerType ) : Bool;
}