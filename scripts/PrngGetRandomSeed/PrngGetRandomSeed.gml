// Feather disable all

function PrngGetRandomSeed()
{
    static _default = __PrngSystem();
    return _default.GetRandomSeed();
}