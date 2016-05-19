package hex.data;

/**
 * @author Francis Bourre
 */
interface IParser<ResultType>
{
	function parse( serializedContent : Dynamic, target : Dynamic = null ) : ResultType;
}