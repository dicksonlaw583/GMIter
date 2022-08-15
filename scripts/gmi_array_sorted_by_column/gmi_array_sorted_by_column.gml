///@func gmi_array_sorted_by_column(arr, n, sortType)
///@arg {array} arr The original array.
///@arg {real} n The column to sort by.
///@arg {bool} sortType (optional) true to sort ascending, false to sort descending.
///@return {array}
///@desc Sort the array with array_sort by the nth column and return it.
//Feather disable GM1045
function gmi_array_sorted_by_column(arr, n, sortType=true) {
	array_sort(arr, method({n: n, sortType: sortType}, function(a, b) {
		return sortType ? (a[n]-b[n]) : (b[n]-a[n]);
	}));
	return arr;
}