// Feather disable all

/// @param value

function PrngIRandom(_value)
{
    static _default = __PrngSystem();
    return _default.IRandom(_value);
}