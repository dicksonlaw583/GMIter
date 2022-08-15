///@func GMIterMap(...)
///@pure
///@desc Utility for generating DS maps out of pairwise arguments.
function GMIterMap(){
	var map = ds_map_create();
	for (var i = 0; i < argument_count; i += 2) {
		map[? argument[i]] = argument[i+1];
	}
	return map;
}
