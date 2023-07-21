///@func CircleIter(cx, cy, r, n, [angleStart], [angleEnd], [includeEnd])
///@arg {real} cx The centre's X position.
///@arg {real} cy The centre's Y position.
///@arg {real} r The circle's radius.
///@arg {real} n The number of points to sample.
///@arg {real} [angleStart] The angle in degrees to begin looping from (default: 0)
///@arg {real} [angleEnd] The angle in degrees to stop looping at (default: 360)
///@arg {bool} [includeEnd] Whether to include the ending point (default: false)
///@desc Iterate n points on an ellipse.
function CircleIter(cx, cy, r, n, angleStart=0, angleEnd=angleStart+360, includeEnd=false) : EllipseIter(cx, cy, r, r, n, angleStart, angleEnd, includeEnd) constructor {
}
