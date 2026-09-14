/// @desc Creates a collection of PRNG tracks to pull random outputs from. Aside from seed-specific function, you can use the album itself just like you would a PrngGenerator.
/// @param {real} seed The seed of the PrngAlbum, converted to int64. IMPORTANT! This is NOT the same as the seed in juju's regular PRNG Library, where seed and state are interchangable terms.

function PrngAlbum(_seed = undefined) constructor
{
    seed = int64(_seed ?? 0);
    
    tracks = {};
    tracks.main = new PrngGenerator();
    tracks.main.SetSeed(seed);
    
    /// @desc returns the PrngGenerator associated with the given track for future RNG use.
    /// @param {string} track the track to use.
    /// @returns {struct.PrngGenerator} 
    static FromTrack = function(_track = "main")
    {
        if (tracks[$ _track] == undefined)
        {
            var _newTrack = new PrngGenerator();
            _newTrack.SetSeed(seed);
            _newTrack.AdjustSeedFromString(_track);
            tracks[$ _track] = _newTrack;
        }
        
        return tracks[$ _track];
    }
    
    static Randomize = function()
    {
        tracks.main.Randomize();
        seed = tracks.main.GetSeed();
        var _keys = struct_get_names(tracks);
        var _length = array_length(_keys);
        for(var i = 0; i < _length; i++)
        {
            var current = tracks[$ _keys[i]];
            if (current == "main") continue;
            current.SetSeed(seed);
            current.AdjustSeedFromString(_keys[i]);
        }
    }
    
    static SetSeed = function(_seed)
    {
        seed = int64(seed);
        tracks.main.SetSeed(_seed);
    }
    
    static GetSeed = function()
    {
        return seed;
    }
    
    static Random = function(_value)
    {
        return tracks.main.Random(_value);
    }
    
    static RandomRange = function(_min, _max)
    {
        return tracks.main.RandomRange(_min, _max);
    }
    
    static IRandom = function(_value)
    {
        return tracks.main.IRandom(_value);
    }
    
    static IRandomRange = function(_min, _max)
    {
        return tracks.main.IRandomRange(_min, _max);
    }
    
    static ChooseArray = function(_array)
    {
        return tracks.main.ChooseArray(_array);
    }
    
    static Chance = function(_percent)
    {
        return tracks.main.Chance(_percent);
    }
    
    static Dice = function(_number, _sides)
    {
        return tracks.main.Dice(_number, _sides);
    }
    
    static Weighted = function(_weightsArray, _valuesArray = undefined)
    {
        return tracks.main.Weighted(_weightsArray, _valuesArray);
    }
    
    static ArrayShuffle = function(_array)
    {
        tracks.main.ArrayShuffle(_array)
    }
    
    static RandomNormal = function(_deviation = 1, _mean = 0)
    {
        //Box-Muller transform from 2 uniform samples (from 0-1) to 1 normal sample
        return tracks.main.RandomNormal(_deviation, _mean)
    }
    
    static MakeExportString = function()
    {
        var serialization_struct = {
            seed: string(seed),
            tracks: {},
        };
        
        var _keys = struct_get_names(tracks);
        var _length = array_length(_keys);
        for(var i = 0; i < _length; i++)
        {
            serialization_struct.tracks[$ _keys[i]] = string(tracks[$ _keys[i]].GetSeed());
        }
        
        return json_stringify(serialization_struct);
    }
    
    static FromExportString = function(_exportString)
    {
        var _importAlbum = json_parse(_exportString);
        seed = int64(_importAlbum.seed);
        tracks = {};
        
        var _keys = struct_get_names(_importAlbum.tracks);
        var _length = array_length(_keys);
        for(var i = 0; i < _length; i++)
        {
            var generator = new PrngGenerator();
            generator.SetSeed(int64(_importAlbum.tracks[$ _keys[i]]));
            tracks[$ _keys[i]] = generator;
        }
    }
}

