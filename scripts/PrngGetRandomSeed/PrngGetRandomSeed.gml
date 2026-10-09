// Feather disable all

function PrngGetRandomState()
{
    static _default = __PrngSystem();
    return _default.GetRandomState();
}