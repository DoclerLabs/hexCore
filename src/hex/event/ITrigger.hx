package hex.event;

/**
 * @author Francis Bourre
 */
interface ITrigger<Connection> 
{
	function connect( input : Connection ) : Bool;
	function disconnect( input : Connection ) : Bool;
}