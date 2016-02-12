package hex.config.stateless;

/**
 * ...
 * @author Francis Bourre
 */
interface IStatelessConfig
{
    /**
     * Configure will be invoked after dependencies have been supplied
     */
    function configure() : Void;
}