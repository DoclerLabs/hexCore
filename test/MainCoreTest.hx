package;

import hex.HexCoreSuite;
import hex.unittest.notifier.ConsoleNotifier;
import hex.unittest.runner.ExMachinaUnitCore;

/**
 * ...
 * @author Francis Bourre
 */
class MainCoreTest
{
	static public function main() : Void
	{
		var emu : ExMachinaUnitCore = new ExMachinaUnitCore();
        emu.addListener( new ConsoleNotifier() );
        emu.addTest( HexCoreSuite );
        emu.run();
	}
}