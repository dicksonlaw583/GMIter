///@func ArrayIter(array)
///@arg {Array} array The array to iterate through.
///@desc Iterate through an array.
function ArrayIter(array) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return index < n;
	};

	///@func next()
	///@desc Go to the next iteration.
	
	static next = function() {
		
		if (++index > n) {
			throw new GMIterNextException(self);
		}
		value = (index < n) ? array[index] : undefined;
	};

	// Constructor
	self.array = array;
	n = array_length(array);
	index = 0;
	value = (index < n) ? array[index] : undefined;
}
