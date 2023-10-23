// Feather disable all

function PrngGetSeed()
{
    static _default = __PrngSystem();
    return _default.GetSeed();
}