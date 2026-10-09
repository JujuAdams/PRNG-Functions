// Feather disable all

function PrngAdjustStateFromString(_string)
{
    static _default = __PrngSystem();
    return _default.AdjustStateFromString(_string);
}