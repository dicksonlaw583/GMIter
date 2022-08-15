///@func DsListIter(list)
///@arg {Id.DsList} list The DS list to iterate through.
///@desc Iterate through a DS list.
function DsListIter(list) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return index < n;
	};

	///@func next()
	///@desc Go to the next iteration.
	static next = function() {
		if (++index > n) {
			throw new GMIterNextException(self);
		}
		value = (index < n) ? list[| index] : undefined;
	};

	// Constructor
	self.list = list;
	n = ds_list_size(list);
	index = 0;
	value = (index < n) ? list[| index] : undefined;
}
