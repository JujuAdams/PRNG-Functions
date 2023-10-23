// Feather disable all

/// @param array

function PrngArrayShuffle(_array)
{
    static _default = __PrngSystem();
    return _default.ArrayShuffle(_array);
}