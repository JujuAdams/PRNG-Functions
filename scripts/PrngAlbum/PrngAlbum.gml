/// @desc Creates a collection of PRNG tracks to pull random outputs from. Aside from seed-specific function, you can use the album itself just like you would a PrngGenerator.
/// @param {real} seed The seed of the PrngAlbum, converted to int64. IMPORTANT! This is NOT the same as the seed in juju's regular PRNG Library, where seed and state are interchangable terms.
function PrngAlbum (seed = undefined) constructor{
    
    self.tracks = {};
    self.seed = int64(seed ?? 0);
    self.tracks.main = new PrngGenerator();
    self.tracks.main.SetSeed(self.seed);
    
    /// @desc returns the PrngGenerator associated with the given track for future RNG use.
    /// @param {string} track the track to use.
    /// @returns {struct.PrngGenerator} 
    static FromTrack = function(track = "main"){
        if(is_undefined(tracks[$ track])){
            var new_track = new PrngGenerator();
            new_track.SetSeed(seed);
            new_track.AdjustSeedFromString(track);
            tracks[$ track] = new_track;
        }
        
        return tracks[$ track];
    }
    
    static Randomize = function()
    {
        tracks.main.Randomize();
        seed = tracks.main.GetSeed();
        var keys = struct_get_names(self.tracks);
        var length = array_length(keys);
        for(var i = 0; i < length; i++){
            var current = tracks[$ keys[i]];
            if(current == "main")continue;
            current.SetSeed(seed);
            current.AdjustSeedFromString(keys[i]);
        }
    }
    
    static SetSeed = function(_seed)
    {
        self.seed = int64(seed);
        tracks.main.SetSeed(_seed);
    }
    
    static GetSeed = function()
    {
        return seed;
    }
    
    static Random = function(value)
    {
        return tracks.main.Random(value);
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
        return tracks.main.Dice(_number,_sides);
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
        return tracks.main.RandomNormal(_deviation,_mean)
    }
    
    static MakeExportString = function(){
        var serialization_struct = {seed:string(self.seed),tracks:{}}
        var keys = struct_get_names(self.tracks);
        var length = array_length(keys);
        for(var i = 0; i<length; i++){
            serialization_struct.tracks[$ keys[i]] = string(self.tracks[$ keys[i]].GetSeed());
        }
        return json_stringify(serialization_struct);
    }
    
    static FromExportString = function(export_string){
        var import_album = json_parse(export_string);
        self.seed = int64(import_album.seed);
        self.tracks = {};
        
        var keys = struct_get_names(import_album.tracks);
        var length = array_length(keys);
        for(var i = 0; i<length; i++){
            var generator = new PrngGenerator();
            generator.SetSeed(int64( import_album.tracks[$ keys[i]] ) );
            self.tracks[$ keys[i]] = generator;
        }
        
    }
}

