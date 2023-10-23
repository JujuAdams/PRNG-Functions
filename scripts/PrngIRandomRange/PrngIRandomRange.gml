// Feather disable all

/// @param min
/// @param max

function PrngIRandomRange(_min, _max)
{
    static _default = __PrngSystem();
    return _default.IRandomRange(_min, _max);
}