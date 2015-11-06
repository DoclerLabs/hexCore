package hex.data;

/**
 * @author Francis Bourre
 */
interface IParser 
{
	function parse( serializedContent : Dynamic, target : Dynamic = null ) : Dynamic;
}