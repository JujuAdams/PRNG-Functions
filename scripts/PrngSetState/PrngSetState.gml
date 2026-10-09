// Feather disable all

/// This function sets the PRNG state directly. Inputs similar in value (e.g. `17` and `18`)
/// will generate random numbers that will be close to each other for the first few iterations.
/// To ensure that nearby inputs give very different values please use `PrngSetStateFromString()`.
/// 
/// @param state

function PrngSetState(_state)
{
    static _default = __PrngSystem();
    return _default.SetState(_state);
}