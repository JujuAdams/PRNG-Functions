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
        __state = 0xFFFFFFFF & int64(_state); //I don't trust GameMaker
        
        return (_state / (real(0xFFFFFFFF) + 1.0));
    }
    
    static SetSeed = function(_seed)
    {
        __state = 0xFFFFFFFF & int64(_seed);
    }
    
    static SetSeedFromString = function(_string)
    {
        SetSeed(ptr("0x" + string_copy(md5_string_utf8(string(_string)), 1, 8)));
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
    
    static Chance = function(_percent)
    {
        return (Random(100) <= _percent);
    }
    
    static Dice = function(_number, _sides)
    {
        var _sum = 0;
        repeat(_number) _sum += IRandomRange(1, _sides);
        return _sum;
    }
    
    static Weighted = function(_weightsArray, _valuesArray = undefined)
    {
        var _length = array_length(_weightsArray);
        
        //Calculate the sum of all weights
        var _range = 0;
        var _i = 0;
        repeat(_length)
        {
            _range += _weightsArray[_i];
            ++_i;
        }
        
        //Generate a random number somewhere inside the established range
        var _random = Random(_range);
        
        //Pass back through the weights array and find out which "bucket" the random number points to
        var _i = 0;
        var _index = undefined;
        repeat(_length)
        {
            _random -= _weightsArray[_i];
            
            if (_random <= 0)
            {
                _index = _i;
                break;
            }
            
            ++_i;
        }
        
        if (_index == undefined)
        {
            show_debug_message("Warning! PRNG failed to choose weighted index");
            _index = 0;
        }
        
        if (_valuesArray == undefined)
        {
            return _index;
        }
        else if (not is_array(_valuesArray))
        {
            show_error("Value array was not an array (datatype=" + typeof(_valuesArray) + ")\n ", true);
        }
        
        if (array_length(_valuesArray) != _length)
        {
            show_error("Array length mismatch (weights=" + string(_length) + ", values=" + string(array_length(_valuesArray)) + "\n ", true);
        }
        
        return _valuesArray[_index];
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
    
    static RandomNormal = function(_deviation = 1, _mean = 0)
    {
        //Box-Muller transform from 2 uniform samples (from 0-1) to 1 normal sample
        return _mean + _deviation*sqrt(-2*ln(Random(1)))*cos(2*pi*Random(1));
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