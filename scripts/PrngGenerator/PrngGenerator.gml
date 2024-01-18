// Feather disable all

function PrngGenerator() constructor
{
    __state = int64(1);
    
    static __Iterate = function()
    {
        var _state = __state; //Slightly faster if we cache the state value locally first
        _state ^= _state << 13;
        _state ^= _state >> 17;
        _state ^= _state <<  5;
        __state = int64(_state); //I don't trust GameMaker
        
        return abs(_state) / (real(0x7FFFFFFFFFFFFFFF) + 1.0);
    }
    
    static SetSeed = function(_seed)
    {
        __state = int64(_seed);
    }
    
    static GetSeed = function()
    {
        return __state;
    }
    
    static Randomize = function()
    {
        //Some bullshit idk
        __state = int64(floor(100000*(date_current_datetime() + get_timer()) + display_mouse_get_x() + display_get_width()*display_mouse_get_y()));
    }
    
    static Random = function(_value)
    {
        return _value*__Iterate();
    }
    
    static RandomRange = function(_min, _max)
    {
        return _min + Random(_max - _min);
    }
    
    static IRandom = function(_value)
    {
        return floor(Random(_value + 1))
    }
    
    static IRandomRange = function(_min, _max)
    {
        return _min + IRandom(_max - _min);
    }
    
    static Choose = function()
    {
        return argument[IRandom(argument_count - 1)];
    }
    
    static ChooseArray = function(_array)
    {
        return _array[IRandom(array_length(_array) - 1)];
    }
    
    static ArrayShuffle = function(_array)
    {
        var _i = array_length(_array) - 1;
        repeat(_i)
        {
            var _index = IRandom(_i);
            var _oldValue = _array[@ _index];
            
            _array[@ _index] = _array[_i];
            _array[@ _i    ] = _oldValue;
            
            --_i;
        }
    }
    
    static UUID = function(_hyphenate = false)
    {
        //UUIDv4 as per https://www.cryptosys.net/pki/uuid-rfc4122.html
        
        var _UUID = md5_string_unicode(string(IRandom(0x7FFFFFFFFFFFFFFF)));
        _UUID = string_set_byte_at(_UUID, 13, ord("4"));
        _UUID = string_set_byte_at(_UUID, 17, ord(Choose("8", "9", "a", "b")));
        
        if (_hyphenate)
        {
            _UUID = string_copy(_UUID, 1, 8) + "-" + string_copy(_UUID, 9, 4) + "-" + string_copy(_UUID, 13, 4) + "-" + string_copy(_UUID, 17, 4) + "-" + string_copy(_UUID, 21, 12);
        }
        
        return _UUID;
    }
}