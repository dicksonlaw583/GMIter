///@func DsMapIter(map)
///@arg {Id.DsMap} map The DS map to iterate through.
///@desc Iterate through a DS map.
function DsMapIter(map) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return !is_undefined(index);
	};

	///@func next()
	///@desc Go to the next iteration.
	
	static next = function() {
		if (is_undefined(index)) {
			throw new GMIterNextException(self);
		}
		index = ds_map_find_next(map, index);
		value = is_undefined(index) ? undefined : map[? index];
	};
	
	// Conmapor
	self.map = map;
	if (ds_map_empty(map)) {
		index = undefined;
		value = undefined;
	} else {
		index = ds_map_find_first(map);
		value = map[? index];
	}
}
