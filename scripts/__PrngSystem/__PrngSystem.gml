// Feather disable all

#macro __PRNG_VERSION  "2.1.0"
#macro __PRNG_DATE     "2026-08-20"

function __PrngSystem()
{
    static _default = undefined;
    if (_default != undefined) return _default;
    _default = new PrngGenerator();
    
    show_debug_message("Welcome to PRNG by Juju Adams! This is version " + __PRNG_VERSION + ", " + __PRNG_DATE);
    
    return _default;
}