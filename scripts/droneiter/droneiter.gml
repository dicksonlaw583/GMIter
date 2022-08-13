///@func DroneIter(val, [n])
///@arg val The value to return.
///@arg {real} n The number of times to iterate. If unspecified, iterate indefinitely.
///@desc Iterate n times giving the value val.
function DroneIter(val, n=infinity) : GMIter() constructor {
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are entries to iterate.
	static hasNext = function() {
		return index < times;
	};

	///@func next()
	///@desc Go to the next entry of the array.
	static next = function() {
		if (++index > times) {
			throw new GMIterNextException(self);
		}
	};

	// Constructor
	times = n;
	index = 0;
	value = val;
}
