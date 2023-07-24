///@func LatticeIter(x0, y0, x1, y1, nx, ny, [colMajor])
///@arg {real} x0 The starting corner's X coordinate
///@arg {real} y0 The starting corner's Y coordinate
///@arg {real} x1 The ending corner's X coordinate
///@arg {real} y1 The ending corner's Y coordinate
///@arg {real} nx Number of horizontal sample points per row
///@arg {real} ny Number of vertical sample points per column
///@arg {bool} colMajor (Optional) Whether to iterate in row-major order (false) or column major order (true). Default: false
///@desc Iterate through a 2D grid.
function LatticeIter(x0, y0, x1, y1, nx, ny, colMajor=false) : GMIter() constructor {
	//Feather disable GM1061
	
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more entries to iterate.
	static hasNext = function() {
		return i < nx && j < ny;
	};
	
	///@func next()
	///@desc Go to the next iteration
	static next = function() {
		if (i >= nx || j >= ny) {
			throw new GMIterNextException(self);
		}
		if (colMajor) {
			if (++j >= ny) {
				++i;
				j = 0;
			}
		} else {
			if (++i >= nx) {
				++j;
				i = 0;
			}
		}
		index = [i, j];
		value = (i < nx && j < ny) ? [lerp(x0, x1, i/(nx-1)), lerp(y0, y1, j/(ny-1))] : undefined;
	};
	
	// Constructor
	self.x0 = x0;
	self.y0 = y0;
	self.x1 = x1;
	self.y1 = y1;
	self.nx = nx;
	self.ny = ny;
	self.colMajor = colMajor;
	i = 0;
	j = 0;
	index = [i, j];
	value = (i < nx && j < ny) ? [x0, y0] : undefined;
}
