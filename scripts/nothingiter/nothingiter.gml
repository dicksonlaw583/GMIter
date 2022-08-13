///@func NothingIter()
///@desc A bogus iterator that returns `false` for `hasNext()` and throws an exception if `next()` is called.
function NothingIter() : GMIter() constructor {
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more values to iterate.
	static hasNext = function() {
		return false;
	};
	
	///@func next()
	///@desc Go to the next value.
	static next = function() {
		throw new GMIterNextException(self);
	};
}
