package hex.log;
import hex.domain.Domain;

/**
 * @author Francis Bourre
 */
interface ILogger 
{
	function clear() : Void;
	
	function debug( o : Dynamic ) : Void;
	
	function info( o : Dynamic ) : Void;
	
	function warn( o : Dynamic ) : Void;
	
	function error( o : Dynamic ) : Void;
	
	function fatal( o : Dynamic ) : Void;
	
	function getDomain() : Domain;
}