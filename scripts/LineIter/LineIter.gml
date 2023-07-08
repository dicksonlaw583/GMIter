///@func LineIter(x0, y0, x1, y1, n)
///@arg {real} x0 The starting X position.
///@arg {real} y0 The starting Y position.
///@arg {real} x1 The ending X position.
///@arg {real} y1 The ending Y position.
///@arg {real} n Number of points (including the ends).
///@desc Iterate n points on the line segment from (x0, y0) to (x1, y1), including the endpoints.
function LineIter(x0, y0, x1, y1, n) : GMIter() constructor {
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are more times to iterate.
	static hasNext = function() {
		return count <= n;
	};
	
	///@func next()
	///@desc Go to the next iteration.
	static next = function() {
		if (++count > n+1) {
			throw new GMIterNextException(self);
		}
		progress = count/n;
		index[0] = count;
		index[1] = progress;
		value[0] = lerp(x0, x1, progress);
		value[1] = lerp(y0, y1, progress);
	};
	
	// Constructor
	self.x0 = x0;
	self.y0 = y0;
	self.x1 = x1;
	self.y1 = y1;
	self.n = n-1;
	count = 0;
	progress = 0;
	index = [count, progress];
	value = [x0, y0];
}
