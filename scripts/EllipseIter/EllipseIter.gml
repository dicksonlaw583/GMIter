///@func EllipseIter(cx, cy, rx, ry, n, [angleStart], [angleEnd], [includeEnd])
///@arg {real} cx The centre's X position.
///@arg {real} cy The centre's Y position.
///@arg {real} rx The X radius.
///@arg {real} ry The Y radius.
///@arg {real} n The number of points to sample.
///@arg {real} [angleStart] The angle in degrees to begin looping from (default: 0)
///@arg {real} [angleEnd] The angle in degrees to stop looping at (default: 360)
///@arg {bool} [includeEnd] Whether to include the ending point (default: false)
///@desc Iterate n points on an ellipse.
function EllipseIter(cx, cy, rx, ry, n, angleStart=0, angleEnd=angleStart+360, includeEnd=false) : GMIter() constructor {
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
		index = [count, progress];
		var currentAngle = lerp(angleStart, angleEnd, progress);
		value = [cx+lengthdir_x(rx, currentAngle), cy+lengthdir_y(ry, currentAngle)];
	};
	
	// Constructor
	self.cx = cx;
	self.cy = cy;
	self.rx = rx;
	self.ry = ry;
	self.angleStart = angleStart;
	self.angleEnd = includeEnd ? angleEnd : lerp(angleStart, angleEnd, (n-1)/n);
	self.n = n-1;
	count = 0;
	progress = 0;
	index = [count, progress];
	value = [cx+lengthdir_x(rx, angleStart), cy+lengthdir_y(ry, angleStart)];
}
