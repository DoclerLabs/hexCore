package hex.event;

/**
 * ...
 * @author Francis Bourre
 */
class CompositeDispatcherTest
{
	var _dispatcher : CompositeDispatcher;
	
	public function new() { }
	
	@Before
    public function setUp() : Void
    {
        this._dispatcher    = new CompositeDispatcher();
    }

    @After
    public function tearDown() : Void
    {
        this._dispatcher    = null;
    }
	
}