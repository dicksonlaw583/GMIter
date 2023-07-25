///@func ConcatIter([...])
///@desc Iterate through any number of iterators head-to-tail.
function ConcatIter() : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		var i;
		var nIters = array_length(iters);
		for (i = iterPos; i < nIters; ++i) {
			if (iters[i].hasNext()) return true;
		}
		return false;
	};
	
	///@func next()
	///@desc Go to the next iteration
	static next = function() {
		if (!hasNext()) {
			throw new GMIterNextException(self);
		}
		iters[iterPos].next();
		while (iterPos < array_length(iters) && !iters[iterPos].hasNext()) {
			++iterPos;
		}
		if (iterPos < array_length(iters)) {
			var currentIter = iters[iterPos];
			index = currentIter.index;
			value = currentIter.value;
		} else {
			index = undefined;
			value = undefined;
		}
	};
	
	// Constructor
	iterPos = 0;
	iters = array_create(argument_count);
	for (var i = argument_count-1; i >= 0; --i) {
		iters[i] = argument[i];
	}
	while (iterPos < argument_count && !iters[iterPos].hasNext()) {
		++iterPos;
	}
	if (iterPos < argument_count && iters[iterPos].hasNext()) {
		index = iters[iterPos].index;
		value = iters[iterPos].value;
	} else {
		index = undefined;
		value = undefined;
	}
}
