///@func TimesIter([n])
///@arg {real} n The number of times to iterate. If unspecified, iterate indefinitely.
///@desc Iterate n times.
function TimesIter(n=infinity) : GMIter() constructor {
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more times to iterate.
	static hasNext = function() {
		return index < times;
	};

	///@func next()
	///@desc Go to the next iteration.
	static next = function() {
		if (++index > times) {
			throw new GMIterNextException(self);
		}
		++value;
	};

	// Constructor
	times = n;
	index = 0;
	value = 0;
}
