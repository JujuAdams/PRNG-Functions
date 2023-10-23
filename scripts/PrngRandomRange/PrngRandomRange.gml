// Feather disable all

/// @param min
/// @param max

function PrngRandomRange(_min, _max)
{
    static _default = __PrngSystem();
    return _default.RandomRange(_min, _max);
}