///@func PathIter(path, n, [p0], [p1])
///@arg {Asset.GMPath} path The path to use.
///@arg {real} n Number of points (including the ends).
///@arg {real} p0 The fraction of path to start from. Default: 0
///@arg {real} p1 The fraction of path to end at. Default: 1
///@desc Iterate n points on the path from p0 through p1, including the endpoints.
function PathIter(path, n, p0=0, p1=1) : GMIter() constructor {
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
		progress = lerp(p0, p1, count/n);
		index = [count, progress];
		value = [path_get_x(path, progress), path_get_y(path, progress)];
	};
	
	// Constructor
	self.path = path;
	self.n = n-1;
	self.p0 = p0;
	self.p1 = p1;
	count = 0;
	progress = p0;
	index = [count, progress];
	value = [path_get_x(path, p0), path_get_y(path, p0)];
}