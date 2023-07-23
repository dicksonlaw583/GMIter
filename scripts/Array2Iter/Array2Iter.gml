///@func Array2Iter(array, [colMajor])
///@arg {Array<Array>} array The 2D array to iterate through.
///@arg {bool} colMajor (Optional) Whether to iterate in row-major order (false) or column major order (true). Default: false
///@desc Iterate through a 2D array.
function Array2Iter(array, colMajor=false) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return i < m && j < n;
	};
	
	///@func next()
	///@desc Go to the next iteration
	static next = function() {
		if (i >= m || j >= n) {
			throw new GMIterNextException(self);
		}
		if (colMajor) {
			if (++i >= m) {
				++j;
				i = 0;
			}
		} else {
			if (++j >= n) {
				++i;
				j = 0;
			}
		}
		index = [i, j];
		value = (i < m && j < n) ? array[i][j] : undefined;
	};
	
	// Constructor
	self.array = array;
	self.colMajor = colMajor;
	m = 0;
	n = 0;
	if (is_array(array)) {
		m = array_length(array);
		if (m > 0 && is_array(array[0])) {
			n = array_length(array[0]);
		}
	}
	i = 0;
	j = 0;
	index = [i, j];
	value = (i < m && j < n) ? array[i][j] : undefined;
}
