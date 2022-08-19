///@func CsvFileArrayIter(filename)
///@arg {string} filename The headerless CSV file to iterate through.
///@desc Iterate through a headerless CSV file and give rows as arrays.
function CsvFileArrayIter(filename) : GMIter() constructor {
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
		if (++index < n) {
			value = array_create(ds_grid_width(data));
			for (var i = ds_grid_width(data)-1; i >= 0; --i) {
				value[i] = data[# i, index];
			}
		} else {
			index = undefined;
			value = undefined;
		}
	};
	
	///@func close()
	///@desc Close this iterator.
	static close = function() {
		if (!is_undefined(index)) {
			ds_grid_destroy(data);
		}
	};

	// Constructor
	data = load_csv(filename);
	n = ds_exists(data, ds_type_grid) ? ds_grid_height(data) : 0;
	if (n <= 0) {
		index = undefined;
		value = undefined;
	} else {
		index = 0;
		value = array_create(ds_grid_width(data));
		for (var i = ds_grid_width(data)-1; i >= 0; --i) {
			value[i] = data[# i, index];
		}
	}
}
