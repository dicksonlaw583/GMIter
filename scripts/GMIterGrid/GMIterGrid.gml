///@func GMIterGrid(width, height, ...)
///@param {real} width
///@param {real} height
///@pure
///@desc Utility for generating DS grids.
function GMIterGrid(width, height){
	var grid = ds_grid_create(width, height);
	for (var i = 2; i < argument_count; ++i) {
		var ii = i-2;
		grid[# ii mod width, ii div width] = argument[i];
	}
	return grid;
}
