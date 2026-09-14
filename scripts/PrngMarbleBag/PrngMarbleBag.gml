/// @desc Creates a "Marble Bag" rng structure. It has an array of possible "marbles", when you pull a marble from the bag, it is removed from the pool of possible options until the bag is "replenished", restoring all removed options. 
/// @param {array} motherMarbles                   The array of possible marbles to pull from.
/// @param {struct.PrngGenerator} [prngGenerator]  The PrngGenerator to advance whenever the marble bag needs to shuffle its content. If unspecified, uses the internal system PrngGenerator. Can be re-specified when pulling

function PrngMarbleBag(_motherMarbles, _prngGenerator = __PrngSystem()) constructor{
    
    static __indexerFunc = function(index) { return index; }
    motherMarbles = variable_clone(_motherMarbles, 0);
    availableMarbleIndices = [];
    prngGenerator = _prngGenerator;
    
    ReplenishMarbles();
    
    ///@desc Returns a Marble from the Marble Bag, running without parameters is the expected, normal marble bag behavior.
    ///@param {bool} withReplacement  Whether or not to instantly return the marble to the marble pool after being pulled.
    ///@param {bool} replenish        Whether or not to refill the marble bag immediately when it is emptied.
    ///@param {bool} prngGenerator    If specified, use this PrngGenerator instead of the one inherent to the marble bag.
    static PullMarble = function(_withReplacement = false, _replenish = true, _prngGenerator = undefined)
    {
        var _length = array_length(availableMarbleIndices);
        if (_length == 0) return undefined;
        var _index = 0;
        
        if (_withReplacement)
        {
            //sadly we need to truly access a random number if we pull a single marble with replacement. but it's not that big a deal.
            _prngGenerator ??= prngGenerator; //is this bad form? I quite like this but I can very much understand people not liking this
            var _shuffledIndex = _prngGenerator.IRandom(_length-1)
            var _temp = availableMarbleIndices[_shuffledIndex];
            _index = availableMarbleIndices[0];
            availableMarbleIndices[_shuffledIndex] = availableMarbleIndices[0];
            availableMarbleIndices[0] = _temp;
        }
        else
        {
            _index = array_shift(availableMarbleIndices);
        }
        
        var marble = motherMarbles[_index];
        
        if (_replenish && (_length == 1))
        {
            ReplenishMarbles(true, _prngGenerator);
        }
        
        return marble;
    }
    
    static ReplenishMarbles = function(_replace = true, _prngGenerator = undefined)
    {
        var _newArray =  array_create_ext(array_length(motherMarbles), __indexerFunc);
        if (_replace)
        {
            availableMarbleIndices = _newArray;
        }
        else
        {
            availableMarbleIndices = array_concat(availableMarbleIndices,  _newArray);
        }
        
        _prngGenerator ??= prngGenerator;
        _prngGenerator.ArrayShuffle(availableMarbleIndices);
        
        return self;
    }
    
    static AddMarble = function(_marble, _instantlyAvailable = true, _prngGenerator = undefined)
    {
        array_push(motherMarbles, _marble);
        
        if (_instantlyAvailable)
        {
            _prngGenerator ??= prngGenerator;
            var _length = array_length(availableMarbleIndices);
            var _index = _prngGenerator.IRandom(_length);
            array_insert(availableMarbleIndices, _index, _length);
        };
        
        return self;
    }
    
    static RemoveMarble = function(_marble)
    {
        var _index = array_get_index(motherMarbles, _marble);
        if (_index == -1) return;
        
        array_delete(motherMarbles, _index, 1);
        
        var _indexIndex = array_get_index(availableMarbleIndices, _index); //welcome to hell
        if (_indexIndex != -1)
        {
            array_delete(availableMarbleIndices, _indexIndex, 1);
        }
    }
    
    static RemoveMarbleByIndex = function(_index)
    {
        array_delete(motherMarbles, _index, 1);
        var _indexIndex = array_get_index(availableMarbleIndices, _index); //welcome to hell
        if (_indexIndex != -1)
        {
            array_delete(availableMarbleIndices, _indexIndex, 1);
        }
    }
    
    static ChangePrngGenerator = function(_prngGenerator)
    {
        prngGenerator = _prngGenerator;
        return self;
    }
    
    static FromExportString = function(_exportString, _importMotherMarbles = true)
    {
        //importing mother marbles defaults to true, but providing an export string that is missing the mother marbles,
        //results in unimported mother marbles.
        
        var _importStruct = json_parse(_exportString);
        availableMarbleIndices = _importStruct.availableMarbleIndices;
        
        if (not _importMotherMarbles) return self;
        if (_importStruct[$ "motherMarbles"] == undefined) return self;
        
        motherMarbles = _importStruct.motherMarbles;
        return self;
    }
    
    static MakeExportString = function(_exportMarbles = false)
    {
        var _exportStruct = {
            availableMarbleIndices: availableMarbleIndices
        }
        
        if (_exportMarbles)
        {
            //by default we only export the available indices, as the marbles themselves could be unsafe references.
            _exportStruct.motherMarbles = motherMarbles;
        }
        
        //also, we dont export the PRNG generator used. this is just hard/messy to do if the generator isnt the one sotirng the bag, 
        //but since a bag could want ot use different tracks, it just can't do that. up to the user to decide how to handle.
        return json_stringify(_exportStruct);
    }
}
