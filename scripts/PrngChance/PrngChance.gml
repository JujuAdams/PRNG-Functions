// Feather disable all

/// @param percent

function PrngChance(_percent)
{
    static _default = __PrngSystem();
    return _default.Chance(_percent);
}
