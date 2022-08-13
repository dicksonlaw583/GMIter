///@func GMIterNextException(_iter)
///@arg {Struct.GMIter} _iter The iterator throwing this exception.
///@desc An exception for when an iterator calls `next()` when there are no more values to iterate.
function GMIterNextException(_iter) constructor {
	///@func toString()
	///@return {string}
	///@desc Return a string message for this exception.
	static toString = function() {
		return "Iteration out-of-bounds.";
	};

	// Constructor
	iter = _iter;
}
