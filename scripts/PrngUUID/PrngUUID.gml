// Feather disable all

/// @param [hyphenate=false]

function PrngUUID(_hyphenate = false)
{
    static _default = __PrngSystem();
    return _default.UUID(_hyphenate);
}