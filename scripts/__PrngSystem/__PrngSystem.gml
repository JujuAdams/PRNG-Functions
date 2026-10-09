// Feather disable all

#macro __PRNG_VERSION  "3.0.0"
#macro __PRNG_DATE     "2026-10-09"

function __PrngSystem()
{
    static _default = undefined;
    if (_default != undefined) return _default;
    _default = new PrngGenerator();
    
    show_debug_message("Welcome to PRNG by Juju Adams! This is version " + __PRNG_VERSION + ", " + __PRNG_DATE);
    
    return _default;
}