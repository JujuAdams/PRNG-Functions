
/// @desc Creates a "Marble Bag" rng structure. It has an array of possible "marbles", when you pull a marble from the bag, it is removed from the pool of possible options until the bag is "replenished", restoring all removed options. 
/// @param {array} mother_marbles the array of possible marbles to pull from.
/// @param {struct.PrngGenerator} [prng_generator] The PrngGenerator to advance whenever the marble bag needs to shuffle its content. If unspecified, uses the internal system PrngGenerator. Can be re-specified when pulling
function PrngMarbleBag(mother_marbles, prng_generator = __PrngSystem()) constructor{
    
    static __indexer_func = function(index){
        return index;
    }
    self.mother_marbles = variable_clone(mother_marbles, 0);
    self.available_marble_indices = [];
    self.prng_generator = prng_generator;
    
    self.ReplenishMarbles();
    
    ///@desc Returns a Marble from the Marble Bag, running without parameters is the expected, normal marble bag behavior.
    ///@param {bool} with_replacement whether or not to instantly return the marble to the marble pool after being pulled.
    ///@param {bool} replenish whether or not to refill the marble bag immediately when it is emptied.
    ///@param {bool} prng_generator if specified, use this PrngGenerator instead of the one inherent to the marble bag.
    static PullMarble = function(with_replacement = false, replenish = true, prng_generator = undefined){
        var length = array_length(available_marble_indices);
        if(length == 0)return undefined;
        var index = 0;
        
        if(with_replacement){
            
            //sadly we need to truly access a random number if we pull a single marble with replacement. but it's not that big a deal.
            prng_generator ??= self.prng_generator; //is this bad form? I quite like this but I can very much understand people not liking this
            var shuffled_index = prng_generator.IRandom(length-1)
            var temp = available_marble_indices[shuffled_index];
            index = self.available_marble_indices[0];
            self.available_marble_indices[shuffled_index] = self.available_marble_indices[0];
            self.available_marble_indices[0] = temp;
        }else{
            index = array_shift(self.available_marble_indices);
        }
        var marble = mother_marbles[index];
        
        if(replenish && (length-1 == 0) ){
            self.ReplenishMarbles(true,prng_generator);
        }
        
        return marble;
    }
    
    static ReplenishMarbles = function(replace = true, prng_generator = undefined){
        var new_array =  array_create_ext(array_length(mother_marbles),__indexer_func);
        if(replace){
            self.available_marble_indices = new_array;
        }else{
            self.available_marble_indices = array_concat(self.available_marble_indices,  new_array);
        }
        prng_generator ??= self.prng_generator;
        prng_generator.ArrayShuffle(self.available_marble_indices);
        
        return self;
    }
    
    static AddMarble = function(marble, instantly_available = true, prng_generator = undefined){
        array_push(self.mother_marbles,marble);
        if(instantly_available){
            prng_generator ??= self.prng_generator;
            var length = array_length(self.available_marble_indices);
            var index = prng_generator.IRandom(length);
            array_insert(self.available_marble_indices,index,length);
        };
        return self;
    }
    
    static RemoveMarble = function(marble){
        var index = array_get_index(mother_marbles,marble);
        if(index == -1)return;
        
        array_delete(mother_marbles,index,1);
        
        var index_index = array_get_index(available_marble_indices,index); //welcome to hell
        if(index_index != -1){
            array_delete(available_marble_indices,index_index,1);
        }
    }
    
    static RemoveMarbleByIndex = function(index){
        array_delete(mother_marbles,index,1);
        var index_index = array_get_index(available_marble_indices,index); //welcome to hell
        if(index_index != -1){
            array_delete(available_marble_indices,index_index,1);
        }
    }
    
    static ChangePrngGenerator = function(prng_generator){
        self.prng_generator = prng_generator;
        return self;
    }
    
    static FromExportString = function(export_string, import_mother_marbles = true){
        //importing mother marbles defaults to true, but providing an export string that is missing the mother marbles,
        //results in unimported mother marbles.
        
        var import_struct = json_parse(export_string);
        self.available_marble_indices = import_struct.available_marble_indices;
        
        if(!import_mother_marbles)return self;
        if(is_undefined(import_struct[$ "mother_marbles"]))return self;
        
        self.mother_marbles = import_struct.mother_marbles;
        return self;
    }
    
    static MakeExportString = function(export_marbles = false){
        var export_struct = {
            available_marble_indices:self.available_marble_indices
        }
        if(export_marbles){
            //by default we only export the available indices, as the marbles themselves could be unsafe references.
            export_struct.mother_marbles = mother_marbles;
        }
        
        //also, we dont export the PRNG generator used. this is just hard/messy to do if the generator isnt the one sotirng the bag, 
        //but since a bag could want ot use different tracks, it just can't do that. up to the user to decide how to handle.
        return json_stringify(export_struct);
    }
}
