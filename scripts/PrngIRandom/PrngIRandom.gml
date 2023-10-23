// Feather disable all

function PrngIRandom(_value)
{
    static _default = __PrngSystem();
    return _default.IRandom(_value);
}