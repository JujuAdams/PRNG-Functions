// Feather disable all

/// @param numberOfDice
/// @param sides

function PrngDice(_number, _sides)
{
    static _default = __PrngSystem();
    return _default.Dice(_number, _sides);
}