package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CompositeClosureDispatcherTest
{
	private var _dispatcher : CompositeDispatcher;
	
	@setUp
    public function setUp() : Void
    {
        this._dispatcher    = new CompositeDispatcher();
    }

    @tearDown
    public function tearDown() : Void
    {
        this._dispatcher    = null;
    }
	
}