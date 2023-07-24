///@func DsGridIter(grid, [colMajor])
///@arg {Id.DsGrid} grid The DS Grid to iterate through.
///@arg {bool} colMajor (Optional) Whether to iterate in row-major order (false) or column major order (true). Default: false
///@desc Iterate through a 2D grid.
function DsGridIter(grid, colMajor=false) : GMIter() constructor {
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
			if (++j >= n) {
				++i;
				j = 0;
			}
		} else {
			if (++i >= m) {
				++j;
				i = 0;
			}
		}
		index = [i, j];
		value = (i < m && j < n) ? grid[# i, j] : undefined;
	};
	
	// Constructor
	self.grid = grid;
	self.colMajor = colMajor;
	m = ds_grid_width(grid);
	n = ds_grid_height(grid);
	i = 0;
	j = 0;
	index = [i, j];
	value = (i < m && j < n) ? grid[# i, j] : undefined;
}
