///@func gmi_array_sorted(arr, [sortType_or_function])
///@arg {array} arr The original array.
///@arg {bool,function} sortType_or_function (optional) true to sort ascending, false to sort descending, or a function/method for custom sorting.
///@return {array}
///@desc Sort the array with array_sort and return it.
//Feather disable GM1045
function gmi_array_sorted(arr, sortType_or_function=true) {
	array_sort(arr, sortType_or_function)
	return arr;
}