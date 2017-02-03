package hex.control.guard;

import hex.di.IInjectorContainer;

/**
 * ...
 * @author Francis Bourre
 */
interface IGuard extends IInjectorContainer
{
    function approve() : Bool;
}
