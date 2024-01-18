// Feather disable all

/// @param value

function PrngRandom(_value)
{
    static _default = __PrngSystem();
    return _default.Random(_value);
}