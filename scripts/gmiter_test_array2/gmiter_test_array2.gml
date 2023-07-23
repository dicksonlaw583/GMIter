///@func gmiter_test_array2()
function gmiter_test_array2(){
	var spy = new GMIterForEachSpy();
	var array2Iter;
	
	#region Starting state
	array2Iter = new Array2Iter([]);
	assert_equal(array2Iter.index, [0, 0], "Core with Array2Iter - Starting state - Bad index for empty");
	assert_equal(array2Iter.value, undefined, "Core with Array2Iter - Starting state - Bad value for empty");
	assert_equal(array2Iter.getIndex(), [0, 0], "Core with Array2Iter - Starting state - Bad getIndex() for empty");
	assert_equal(array2Iter.getValue(), undefined, "Core with Array2Iter - Starting state - Bad getValue() for empty");
	
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.index, [0, 0], "Core with Array2Iter - Starting state - index for normal");
	assert_equal(array2Iter.value, "0", "Core with Array2Iter - Starting state - value for normal");
	assert_equal(array2Iter.getIndex(), [0, 0], "Core with Array2Iter - Starting state - getIndex() for normal");
	assert_equal(array2Iter.getValue(), "0", "Core with Array2Iter - Starting state - getValue() for normal");
	#endregion
	
	#region Fetching
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetch(), ["0", "1", "2", "3", "4", "5"], "Core with Array2Iter - Fetching - fetch()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetch(2), ["0", "1"], "Core with Array2Iter - Fetching - fetch(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	assert_equal(array2Iter.fetch(5), ["0", "1", "2", "3"], "Core with Array2Iter - Fetching - Bad fetch(5) overflowing");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetch(), ["0", "2", "4", "1", "3", "5"], "Core with Array2Iter column - Fetching - fetch()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetch(2), ["0", "2"], "Core with Array2Iter column - Fetching - fetch(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	assert_equal(array2Iter.fetch(5), ["0", "2", "1", "3"], "Core with Array2Iter column - Fetching - Bad fetch() overflowing");
	
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchIndices(), [[0, 0], [0, 1], [1, 0], [1, 1], [2, 0], [2, 1]], "Core with Array2Iter - Fetching - fetchIndices()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchIndices(2), [[0, 0], [0, 1]], "Core with Array2Iter - Fetching - fetchIndices(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	assert_equal(array2Iter.fetchIndices(5), [[0, 0], [0, 1], [1, 0], [1, 1]], "Core with Array2Iter - Fetching - Bad fetchIndices(5) overflowing");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchIndices(), [[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]], "Core with Array2Iter column - Fetching - fetchIndices()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchIndices(2), [[0, 0], [1, 0]], "Core with Array2Iter column - Fetching - fetchIndices(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	assert_equal(array2Iter.fetchIndices(5), [[0, 0], [1, 0], [0, 1], [1, 1]], "Core with Array2Iter column - Fetching - Bad fetchIndices(5) overflowing");
	
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchValueIndexArray(), [["0", [0, 0]], ["1", [0, 1]], ["2", [1, 0]], ["3", [1, 1]], ["4", [2, 0]], ["5", [2, 1]]], "Core with Array2Iter - Fetching - fetchValueIndexArray()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchValueIndexArray(2), [["0", [0, 0]], ["1", [0, 1]]], "Core with Array2Iter - Fetching - fetchValueIndexArray(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	assert_equal(array2Iter.fetchValueIndexArray(5), [["0", [0, 0]], ["1", [0, 1]], ["2", [1, 0]], ["3", [1, 1]]], "Core with Array2Iter - Fetching - Bad fetchValueIndexArray(5) overflowing");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchValueIndexArray(), [["0", [0, 0]], ["2", [1, 0]], ["4", [2, 0]], ["1", [0, 1]], ["3", [1, 1]], ["5", [2, 1]]], "Core with Array2Iter column - Fetching - fetchValueIndexArray()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchValueIndexArray(2), [["0", [0, 0]], ["2", [1, 0]]], "Core with Array2Iter column - Fetching - fetchValueIndexArray(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	assert_equal(array2Iter.fetchValueIndexArray(5), [["0", [0, 0]], ["2", [1, 0]], ["1", [0, 1]], ["3", [1, 1]]], "Core with Array2Iter column - Fetching - Bad fetchValueIndexArray(5) overflowing");
	
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchValueIndexStruct(), GMIterStruct([0, 0], "0", [0, 1], "1", [1, 0], "2", [1, 1], "3", [2, 0], "4", [2, 1], "5"), "Core with Array2Iter - Fetching - fetchValueIndexStruct()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	assert_equal(array2Iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], "0", [0, 1], "1"), "Core with Array2Iter - Fetching - fetchValueIndexStruct(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	assert_equal(array2Iter.fetchValueIndexStruct(5), GMIterStruct([0, 0], "0", [0, 1], "1", [1, 0], "2", [1, 1], "3"), "Core with Array2Iter - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchValueIndexStruct(), GMIterStruct([0, 0], "0", [1, 0], "2", [2, 0], "4", [0, 1], "1", [1, 1], "3", [2, 1], "5"), "Core with Array2Iter column - Fetching - fetchValueIndexStruct()");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	assert_equal(array2Iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], "0", [1, 0], "2"), "Core with Array2Iter column - Fetching - fetchValueIndexStruct(2)");
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	assert_equal(array2Iter.fetchValueIndexStruct(5), GMIterStruct([0, 0], "0", [1, 0], "2", [0, 1], "1", [1, 1], "3"), "Core with Array2Iter column - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	#endregion
	
	#region ForEach
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	array2Iter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with Array2Iter - ForEach - forEach(call)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined], ["3", [1, 1], undefined], ["4", [2, 0], undefined], ["5", [2, 1], undefined]], "Core with Array2Iter - ForEach - forEach(call)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	array2Iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with Array2Iter - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined]], "Core with Array2Iter - ForEach - forEach(call, 3)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	array2Iter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with Array2Iter - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined], ["3", [1, 1], undefined]], "Core with Array2Iter - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	array2Iter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with Array2Iter - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [["0", [0, 0], 4321], ["1", [0, 1], 4321], ["2", [1, 0], 4321]], "Core with Array2Iter - ForEach - forEach(call, 3, 4321)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	array2Iter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with Array2Iter column - ForEach - forEach(call)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["4", [2, 0], undefined], ["1", [0, 1], undefined], ["3", [1, 1], undefined], ["5", [2, 1], undefined]], "Core with Array2Iter column - ForEach - forEach(call)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	array2Iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with Array2Iter column - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["1", [0, 1], undefined]], "Core with Array2Iter column - ForEach - forEach(call, 3)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	array2Iter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with Array2Iter column - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["1", [0, 1], undefined], ["3", [1, 1], undefined]], "Core with Array2Iter column - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	array2Iter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with Array2Iter column - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [["0", [0, 0], 4321], ["2", [1, 0], 4321], ["4", [2, 0], 4321]], "Core with Array2Iter column - ForEach - forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var array2IterResult;
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	array2IterResult = array2Iter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with Array2Iter - FetchForEach - fetchForEach(call)");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined], ["3", [1, 1], undefined], ["4", [2, 0], undefined], ["5", [2, 1], undefined]], "Core with Array2Iter - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	array2IterResult = array2Iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with Array2Iter - FetchForEach - fetchForEach(call, 3)");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined]], "Core with Array2Iter - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]]);
	array2IterResult = array2Iter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with Array2Iter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["1", [0, 1], undefined], ["2", [1, 0], undefined], ["3", [1, 1], undefined]], "Core with Array2Iter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]]);
	array2IterResult = array2Iter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with Array2Iter - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(array2IterResult, [["0", [0, 0], 4321], ["1", [0, 1], 4321], ["2", [1, 0], 4321]], "Core with Array2Iter - FetchForEach - fetchForEach(call, 3, 4321)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	array2IterResult = array2Iter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with Array2Iter column - FetchForEach - fetchForEach(call)");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["4", [2, 0], undefined], ["1", [0, 1], undefined], ["3", [1, 1], undefined], ["5", [2, 1], undefined]], "Core with Array2Iter column - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	array2IterResult = array2Iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with Array2Iter column - FetchForEach - fetchForEach(call, 3)");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["1", [0, 1], undefined]], "Core with Array2Iter column - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"]], true);
	array2IterResult = array2Iter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with Array2Iter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(array2IterResult, [["0", [0, 0], undefined], ["2", [1, 0], undefined], ["1", [0, 1], undefined], ["3", [1, 1], undefined]], "Core with Array2Iter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	array2Iter = new Array2Iter([["0", "1"], ["2", "3"], ["4", "5"]], true);
	array2IterResult = array2Iter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with Array2Iter column - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(array2IterResult, [["0", [0, 0], 4321], ["2", [1, 0], 4321], ["4", [2, 0], 4321]], "Core with Array2Iter column - FetchForEach - fetchForEach(call, 3, 4321)");
	#endregion
}
