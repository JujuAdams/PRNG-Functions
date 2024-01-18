// Feather disable all

/// @param array

function PrngChooseArray(_array)
{
    static _default = __PrngSystem();
    return _default.ChooseArray(_array);
}