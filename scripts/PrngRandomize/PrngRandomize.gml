// Feather disable all

function PrngRandomize()
{
    static _default = __PrngSystem();
    return _default.Randomize();
}