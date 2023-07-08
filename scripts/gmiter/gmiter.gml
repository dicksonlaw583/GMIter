///@func GMIter()
///@desc Base class for all GMIter iterator classes.
function GMIter() constructor {
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
	
	///@func getIndex()
	///@return {Any}
	///@desc Return the current index. If index is an array, return a shallow copy of it.
	static getIndex = function() {
		//Feather disable GM1045
		if (is_array(index)) {
			var arr = [];
			array_copy(arr, 0, index, 0, array_length(index));
			return arr;
		} else {
			return index;
		}
	};
	
	///@func getValue()
	///@return {Any}
	///@desc Return the current value. If value is an array, return a shallow copy of it.
	static getValue = function() {
		//Feather disable GM1045
		if (is_array(value)) {
			var arr = [];
			array_copy(arr, 0, value, 0, array_length(value));
			return arr;
		} else {
			return value;
		}
	};
	
	///@func fetch([n])
	///@arg {real} n (Optional) Maximum number of values to retrieve. Default: infinity
	///@return {Array<Any*>}
	///@desc Iterate and return an array of the next n values. If n is unspecified, continue until hasNext() returns false.
	static fetch = function(n=infinity) {
		//Feather disable GM1045
		var arr = [];
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			array_push(arr, value);
			next();
		}
		return arr;
	};
	
	///@func fetchIndices([n])
	///@arg {real} n (Optional) Maximum number of indices to retrieve. Default: infinity
	///@return {Array<Any>}
	///@desc Iterate and return an array of the next n indices. If n is unspecified, continue until hasNext() returns false.
	static fetchIndices = function(n=infinity) {
		var arr = [];
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			array_push(arr, index);
			next();
		}
		return arr;
	};
	
	///@func fetchValueIndexArray([n])
	///@arg {real} n (Optional) Maximum number of iterations to retrieve. Default: infinity
	///@return {Array<Array<Any>>}
	///@desc Iterate and return an array of the next n values and indices, in [[value0, index0], [value1, index1], ...] form. If n is unspecified, continue until hasNext() returns false.
	static fetchValueIndexArray = function(n=infinity) {
		var arr = [];
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			array_push(arr, [value, index]);
			next();
		}
		return arr;
	};
	
	///@func fetchValueIndexStruct([n])
	///@arg {real} n (Optional) Maximum number of iterations to retrieve. Default: infinity
	///@return {Struct}
	///@desc Iterate and return an array of the next n values and indices, in { index0: value0, index1: value1, ... } form. The index will be string()-ed, and if there are any duplicate indices, the last corresponding value is used. If n is unspecified, continue until hasNext() returns false.
	static fetchValueIndexStruct = function(n=infinity) {
		var strc = {};
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			strc[$ string(index)] = value;
			next();
		}
		return strc;
	};
	
	///@func forEach(func, [n], [funcArg])
	///@arg {function} func The method to run for each value. It must take the current value as its first argument. Beyond that, it may take optionally the index as its second argument and the value of funcArg as its third argument.
	///@arg {real} n (Optional) Maximum number of times to iterate. Default: infinity
	///@arg funcArg (Optional) The third parameter to pass to the given function.
	///@desc Run the given method for the next n values. If n is unspecified, continue until hasNext() returns false.
	static forEach = function(func, n=infinity, funcArg=undefined) {
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			func(value, index, funcArg);
			next();
		}
	};
	
	///@func fetchForEach(func, [n], [funcArg])
	///@arg {function} func The method to run for each value. It must take the current value as its first argument and return some value to collect. Beyond that, it may take optionally the index as its second argument and the value of funcArg as its third argument.
	///@arg {real} n (Optional) Maximum number of times to iterate. Default: infinity
	///@arg funcArg (Optional) The third parameter to pass to the given function.
	///@return {Array<Any>}
	///@desc Run the given method for the next n values and return an array of their return values. If n is unspecified, continue until hasNext() returns false.
	static fetchForEach = function(func, n=infinity, funcArg=undefined) {
		var arr = [];
		for (var i = n-1; i >= 0; --i) {
			if (!hasNext()) break;
			array_push(arr, func(value, index, funcArg));
			next();
		}
		return arr;
	};
	
	/// Constructor
	index = undefined;
	value = undefined;
}
