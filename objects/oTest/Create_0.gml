var _x = 20;
var _y = 30;
PrngSetSeedFromString(string(_x) + "," + string(_y));

repeat(10)
{
    show_debug_message(string_format(PrngRandom(1), 0, 10));
}

repeat(10)
{
    show_debug_message(string_format(PrngRandomRange(1, 3), 0, 10));
}

repeat(10)
{
    show_debug_message(PrngIRandom(1));
}

repeat(10)
{
    show_debug_message(PrngIRandomRange(1, 3));
}

repeat(10)
{
    show_debug_message(PrngChoose("A", "B", "C"));
}

repeat(10)
{
    var _array = [1, 2, 3];
    PrngArrayShuffle(_array);
    show_debug_message(_array);
}

repeat(5)
{
    show_debug_message(PrngUUID());
}

repeat(5)
{
    show_debug_message(PrngUUID(true));
}

repeat(20)
{
    show_debug_message(PrngRandomNormal());
}

repeat(10)
{
    show_debug_message(string(ptr(PrngGetRandomSeed())));
}

var _count = room_width*room_height;
buffer = buffer_create(4*_count, buffer_fixed, 1);
surface = -1;
distributionArray = array_create(256, 0);

var _buffer = buffer;
var _distributionArray = distributionArray;

var _pos = 0;
repeat(_count)
{
    var _value = PrngIRandom(0xFF);
    ++_distributionArray[@ _value];
    
    buffer_poke(_buffer, _pos, buffer_u32, 0xFF_000000 | (_value << 16) | (_value << 8) | _value);
    _pos += 4;
}

var _expected = _count / 256;
var _i = 0;
repeat(256)
{
    _distributionArray[@ _i] /= _expected;
    ++_i;
}