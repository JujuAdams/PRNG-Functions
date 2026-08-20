// Feather disable all

/// N.B. This function sets the PRNG state directly. Seeds similar in value (e.g. `17` and `18`)
///      will generate random numbers that will be close to each other for the first few iterations.
///      To ensure that nearby seeds give very different values please use `PrngSetSeedFromString()`.
/// 
/// @param seed

function PrngSetSeed(_seed)
{
    static _default = __PrngSystem();
    return _default.SetSeed(_seed);
}