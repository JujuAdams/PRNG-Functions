// Feather disable all

/// @param weightsArray
/// @param [valuesArray]

function PrngWeighted(_weightsArray, _valuesArray)
{
    static _default = __PrngSystem();
    return _default.Weighted(_weightsArray, _valuesArray);
}