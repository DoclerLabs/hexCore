package hex.log;

import haxe.PosInfos;
import hex.domain.Domain;

/**
 * @author Francis Bourre
 */
interface ILogger 
{
	function clear() : Void;
	
	function debug( o : Dynamic, ?posInfos : PosInfos ) : Void;
	
	function info( o : Dynamic, ?posInfos : PosInfos ) : Void;
	
	function warn( o : Dynamic, ?posInfos : PosInfos ) : Void;
	
	function error( o : Dynamic, ?posInfos : PosInfos ) : Void;
	
	function fatal( o : Dynamic, ?posInfos : PosInfos ) : Void;
	
	function getDomain() : Domain;
}