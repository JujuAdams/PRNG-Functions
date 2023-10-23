// Feather disable all

function PrngRandom(_value)
{
    static _default = __PrngSystem();
    return _default.Random(_value);
}