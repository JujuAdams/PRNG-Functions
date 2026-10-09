// Feather disable all

/// @param state

function PrngSetStateFromString(_state)
{
    static _default = __PrngSystem();
    return _default.SetStateFromString(_state);
}