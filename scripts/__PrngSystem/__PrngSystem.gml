// Feather disable all

function __PrngSystem()
{
    static _default = undefined;
    if (_default != undefined) return _default;
    _default = new PrngGenerator();
    
    show_debug_message("Welcome to PRNG by Juju Adams!");
    
    return _default;
}