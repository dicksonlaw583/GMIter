///@func StructIter(struct)
///@arg {Struct} struct The struct to iterate through.
///@desc Iterate through an struct.
function StructIter(struct) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return i < n;
	};

	///@func next()
	///@desc Go to the next iteration.
	
	static next = function() {
		if (++i > n) {
			throw new GMIterNextException(self);
		}
		if (i < n) {
			index = keys[i];
			value = struct[$ index];
		} else {
			index = undefined;
			value = undefined;
		}
	};
	
	// Constructor
	self.struct = struct;
	keys = variable_struct_get_names(struct);
	i = 0;
	n = array_length(keys);
	if (i < n) {
		index = keys[i];
		value = struct[$ index];
	} else {
		index = undefined;
		value = undefined;
	}
}
