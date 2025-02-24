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