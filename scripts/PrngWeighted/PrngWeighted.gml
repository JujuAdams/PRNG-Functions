// Feather disable all

/// Weighted random choice. If valuesArray is not specified then an integer index is returned.
/// 
/// @param weightsArray
/// @param [valuesArray]

function PrngWeighted(_weightsArray, _valuesArray)
{
    static _default = __PrngSystem();
    return _default.Weighted(_weightsArray, _valuesArray);
}