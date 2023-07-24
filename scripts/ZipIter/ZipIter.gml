///@func ZipIter([...])
///@desc Iterate through any number of iterators in parallel, giving an array of indices and values.
function ZipIter() : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		for (var i = array_length(iters)-1; i >= 0; --i) {
			if (!iters[i].hasNext()) {
				return false;
			}
		}
		return true;
	};
	
	///@func next()
	///@desc Go to the next iteration
	static next = function() {
		var nIters = array_length(iters);
		index = array_create(nIters);
		value = array_create(nIters);
		for (var i = nIters-1; i >= 0; --i) {
			if (!iters[i].hasNext()) {
				throw new GMIterNextException(self);
			}
			iters[i].next();
			index[i] = iters[i].index;
			value[i] = iters[i].value;
		}
	};

	// Constructor
	iters = array_create(argument_count);
	index = array_create(argument_count);
	value = array_create(argument_count);
	for (var i = argument_count-1; i >= 0; --i) {
		iters[i] = argument[i];
		if (iters[i].hasNext()) {
			index[i] = iters[i].index;
			value[i] = iters[i].value;
		}
	}
}