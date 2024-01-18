// Feather disable all

/// @param [value...]

function PrngChoose()
{
    static _default = __PrngSystem();
    return argument[_default.IRandom(argument_count-1)];
}