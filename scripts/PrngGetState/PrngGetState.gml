// Feather disable all

/// This function returns the current 64-bit state. To restore that state you must use `PrngSetState()`.

function PrngGetState()
{
    static _default = __PrngSystem();
    return _default.GetState();
}