///@func GMIterForEachSpy(calls)
///@desc A class with a callback that tracks calls made into it.
function GMIterForEachSpy(calls=[]) constructor {
	///@func call(...)
	///@return {Array<Any*>}
	///@desc Give this method as a callback to test. Return given arguments as an array.
	call = function() {
		var args = array_create(argument_count);
		for (var i = argument_count-1; i >= 0; --i) {
			args[i] = argument[i];
		}
		array_push(calls, args);
		return args;
	};
	
	///@func count()
	///@return {real}
	///@desc Return the number of times this spy's callback was called.
	static count = function() {
		return array_length(calls);
	};
	
	///@func reset()
	///@desc Clear the call log of this spy.
	static reset = function() {
		calls = [];
	};
	
	// Constructor
	self.calls = calls;
}