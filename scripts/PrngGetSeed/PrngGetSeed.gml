// Feather disable all

/// N.B. This function returns the current 64-bit seed. To restore that state you must use
///      `PrngSetSeed()`.

function PrngGetSeed()
{
    static _default = __PrngSystem();
    return _default.GetSeed();
}