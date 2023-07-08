///@func GMIterStruct(...)
///@pure
///@desc Utility for generating structs out of pairwise arguments.
function GMIterStruct(){
	var strc = {};
	for (var i = 0; i < argument_count; i += 2) {
		strc[$ string(argument[i])] = argument[i+1];
	}
	return strc;
}
