// Feather disable all

function PrngAdjustSeedFromString(_string)
{
    static _default = __PrngSystem();
    return _default.AdjustSeedFromString(_string);
}