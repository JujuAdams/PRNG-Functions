// Feather disable all

/// @param [value...]

function PrngChoose()
{
    static _default = __PrngSystem();
    _default.__Iterate();
    return argument[_default.IRandom(argument_count-1)];
}