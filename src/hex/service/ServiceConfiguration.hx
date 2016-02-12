package hex.service;

/**
 * ...
 * @author Francis Bourre
 */
class ServiceConfiguration
{
	public var serviceTimeout : UInt;
	
	public function new( timeout : UInt = 5000 )
	{
		this.serviceTimeout = timeout;
	}
}