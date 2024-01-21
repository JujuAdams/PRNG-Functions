// Feather disable all

function PrngRandomNormal(_deviation = 1,_mean = 0)
{
    static _default = __PrngSystem();
    return _default.RandomNormal(_deviation,_mean);
}