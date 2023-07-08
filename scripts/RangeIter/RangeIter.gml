///@func RangeIter(a, [b], [c])
///@arg {real} a
///@arg {real} b
///@arg {real} c
///@desc Iterate through a range of numbers like Python's range().
///- 1 argument: Iterate integers 0 to a-1.
///- 2 arguments: Iterate integers a to b-1.
///- 3 arguments: Iterate integers a to b-1 in increments of c.
function RangeIter() : GMIter() constructor {	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return sign(hi-value) == sign(step);
	};
	
	///@func next()
	///@desc Go to the next iteration
	static next = function() {
		if (sign(hi-value) != sign(step)) {
			throw new GMIterNextException(self);
		}
		++index;
		value += step;
	};

	// Constructor
	lo = 0;
	hi = 0;
	step = 1;
	switch (argument_count) {
		case 1:
			hi = argument[0];
		break;
		case 3: // Absence of break is intentional here, need to capture lo and hi
			step = argument[2];
		case 2:
			lo = argument[0];
			hi = argument[1];
		break;
		default:
			show_error("Expected 1-3 arguments, got " + string(argument_count) + ".", true);
	}
	index = 0;
	value = lo;
	if (step == 0) {
		show_error("RangeIter step cannot be 0.", true);
	}
}
