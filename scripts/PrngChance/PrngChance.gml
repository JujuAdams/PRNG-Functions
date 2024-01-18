// Feather disable all

/// @param percent

function PrngRandom(_percent)
{
    static _default = __PrngSystem();
    return _default.Chance(_percent);
}