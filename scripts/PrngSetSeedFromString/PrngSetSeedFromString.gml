// Feather disable all

/// @param seed

function PrngSetSeedFromString(_seed)
{
    static _default = __PrngSystem();
    return _default.SetSeedFromString(_seed);
}