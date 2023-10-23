// Feather disable all

/// @param seed

function PrngSetSeed(_seed)
{
    static _default = __PrngSystem();
    return _default.SetSeed(_seed);
}