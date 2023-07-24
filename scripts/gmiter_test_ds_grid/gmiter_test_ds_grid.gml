///@func gmiter_test_ds_grid()
function gmiter_test_ds_grid(){
	var spy = new GMIterForEachSpy();
	var fixture32 = GMIterGrid(3, 2,
		"0", "1", "2",
		"3", "4", "5"
	);
	var fixture22 = GMIterGrid(2, 2,
		"0", "1",
		"2", "3"
	);
	var gridIter;
	
	#region Starting state
	gridIter = new DsGridIter(GMIterGrid(0, 0));
	assert_equal(gridIter.index, [0, 0], "Core with DsGridIter - Starting state - Bad index for empty");
	assert_equal(gridIter.value, undefined, "Core with DsGridIter - Starting state - Bad value for empty");
	assert_equal(gridIter.getIndex(), [0, 0], "Core with DsGridIter - Starting state - Bad getIndex() for empty");
	assert_equal(gridIter.getValue(), undefined, "Core with DsGridIter - Starting state - Bad getValue() for empty");
	ds_grid_destroy(gridIter.grid);
	
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.index, [0, 0], "Core with DsGridIter - Starting state - index for normal");
	assert_equal(gridIter.value, "0", "Core with DsGridIter - Starting state - value for normal");
	assert_equal(gridIter.getIndex(), [0, 0], "Core with DsGridIter - Starting state - getIndex() for normal");
	assert_equal(gridIter.getValue(), "0", "Core with DsGridIter - Starting state - getValue() for normal");
	#endregion
	
	#region Fetching
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetch(), ["0", "1", "2", "3", "4", "5"], "Core with DsGridIter - Fetching - fetch()");
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetch(2), ["0", "1"], "Core with DsGridIter - Fetching - fetch(2)");
	gridIter = new DsGridIter(fixture22);
	assert_equal(gridIter.fetch(5), ["0", "1", "2", "3"], "Core with DsGridIter - Fetching - Bad fetch(5) overflowing");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetch(), ["0", "3", "1", "4", "2", "5"], "Core with DsGridIter column - Fetching - fetch()");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetch(2), ["0", "3"], "Core with DsGridIter column - Fetching - fetch(2)");
	gridIter = new DsGridIter(fixture22, true);
	assert_equal(gridIter.fetch(5), ["0", "2", "1", "3"], "Core with DsGridIter column - Fetching - Bad fetch() overflowing");
	
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchIndices(), [[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]], "Core with DsGridIter - Fetching - fetchIndices()");
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchIndices(2), [[0, 0], [1, 0]], "Core with DsGridIter - Fetching - fetchIndices(2)");
	gridIter = new DsGridIter(fixture22);
	assert_equal(gridIter.fetchIndices(5), [[0, 0], [1, 0], [0, 1], [1, 1]], "Core with DsGridIter - Fetching - Bad fetchIndices(5) overflowing");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchIndices(), [[0, 0], [0, 1], [1, 0], [1, 1], [2, 0], [2, 1]], "Core with DsGridIter column - Fetching - fetchIndices()");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchIndices(2), [[0, 0], [0, 1]], "Core with DsGridIter column - Fetching - fetchIndices(2)");
	gridIter = new DsGridIter(fixture22, true);
	assert_equal(gridIter.fetchIndices(5), [[0, 0], [0, 1], [1, 0], [1, 1]], "Core with DsGridIter column - Fetching - Bad fetchIndices(5) overflowing");
	
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchValueIndexArray(), [["0", [0, 0]], ["1", [1, 0]], ["2", [2, 0]], ["3", [0, 1]], ["4", [1, 1]], ["5", [2, 1]]], "Core with DsGridIter - Fetching - fetchValueIndexArray()");
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchValueIndexArray(2), [["0", [0, 0]], ["1", [1, 0]]], "Core with DsGridIter - Fetching - fetchValueIndexArray(2)");
	gridIter = new DsGridIter(fixture22);
	assert_equal(gridIter.fetchValueIndexArray(5), [["0", [0, 0]], ["1", [1, 0]], ["2", [0, 1]], ["3", [1, 1]]], "Core with DsGridIter - Fetching - Bad fetchValueIndexArray(5) overflowing");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchValueIndexArray(), [["0", [0, 0]], ["3", [0, 1]], ["1", [1, 0]], ["4", [1, 1]], ["2", [2, 0]], ["5", [2, 1]]], "Core with DsGridIter column - Fetching - fetchValueIndexArray()");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchValueIndexArray(2), [["0", [0, 0]], ["3", [0, 1]]], "Core with DsGridIter column - Fetching - fetchValueIndexArray(2)");
	gridIter = new DsGridIter(fixture22, true);
	assert_equal(gridIter.fetchValueIndexArray(5), [["0", [0, 0]], ["2", [0, 1]], ["1", [1, 0]], ["3", [1, 1]]], "Core with DsGridIter column - Fetching - Bad fetchValueIndexArray(5) overflowing");
	
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchValueIndexStruct(), GMIterStruct([0, 0], "0", [1, 0], "1", [2, 0], "2", [0, 1], "3", [1, 1], "4", [2, 1], "5"), "Core with DsGridIter - Fetching - fetchValueIndexStruct()");
	gridIter = new DsGridIter(fixture32);
	assert_equal(gridIter.fetchValueIndexStruct(2), GMIterStruct([0, 0], "0", [1, 0], "1"), "Core with DsGridIter - Fetching - fetchValueIndexStruct(2)");
	gridIter = new DsGridIter(fixture22);
	assert_equal(gridIter.fetchValueIndexStruct(5), GMIterStruct([0, 0], "0", [1, 0], "1", [0, 1], "2", [1, 1], "3"), "Core with DsGridIter - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchValueIndexStruct(), GMIterStruct([0, 0], "0", [0, 1], "3", [1, 0], "1", [1, 1], "4", [2, 0], "2", [2, 1], "5"), "Core with DsGridIter column - Fetching - fetchValueIndexStruct()");
	gridIter = new DsGridIter(fixture32, true);
	assert_equal(gridIter.fetchValueIndexStruct(2), GMIterStruct([0, 0], "0", [0, 1], "3"), "Core with DsGridIter column - Fetching - fetchValueIndexStruct(2)");
	gridIter = new DsGridIter(fixture22, true);
	assert_equal(gridIter.fetchValueIndexStruct(5), GMIterStruct([0, 0], "0", [0, 1], "2", [1, 0], "1", [1, 1], "3"), "Core with DsGridIter column - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	#endregion
	
	#region ForEach
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with DsGridIter - ForEach - forEach(call)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [2, 0], undefined], ["3", [0, 1], undefined], ["4", [1, 1], undefined], ["5", [2, 1], undefined]], "Core with DsGridIter - ForEach - forEach(call)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsGridIter - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [2, 0], undefined]], "Core with DsGridIter - ForEach - forEach(call, 3)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture22);
	gridIter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with DsGridIter - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [0, 1], undefined], ["3", [1, 1], undefined]], "Core with DsGridIter - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsGridIter - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [["0", [0, 0], 4321], ["1", [1, 0], 4321], ["2", [2, 0], 4321]], "Core with DsGridIter - ForEach - forEach(call, 3, 4321)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with DsGridIter column - ForEach - forEach(call)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["3", [0, 1], undefined], ["1", [1, 0], undefined], ["4", [1, 1], undefined], ["2", [2, 0], undefined], ["5", [2, 1], undefined]], "Core with DsGridIter column - ForEach - forEach(call)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsGridIter column - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["3", [0, 1], undefined], ["1", [1, 0], undefined]], "Core with DsGridIter column - ForEach - forEach(call, 3)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture22, true);
	gridIter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with DsGridIter column - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [["0", [0, 0], undefined], ["2", [0, 1], undefined], ["1", [1, 0], undefined], ["3", [1, 1], undefined]], "Core with DsGridIter column - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsGridIter column - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [["0", [0, 0], 4321], ["3", [0, 1], 4321], ["1", [1, 0], 4321]], "Core with DsGridIter column - ForEach - forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var gridIterResult;
	
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIterResult = gridIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with DsGridIter - FetchForEach - fetchForEach(call)");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [2, 0], undefined], ["3", [0, 1], undefined], ["4", [1, 1], undefined], ["5", [2, 1], undefined]], "Core with DsGridIter - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIterResult = gridIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsGridIter - FetchForEach - fetchForEach(call, 3)");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [2, 0], undefined]], "Core with DsGridIter - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture22);
	gridIterResult = gridIter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with DsGridIter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["1", [1, 0], undefined], ["2", [0, 1], undefined], ["3", [1, 1], undefined]], "Core with DsGridIter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32);
	gridIterResult = gridIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsGridIter - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(gridIterResult, [["0", [0, 0], 4321], ["1", [1, 0], 4321], ["2", [2, 0], 4321]], "Core with DsGridIter - FetchForEach - fetchForEach(call, 3, 4321)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIterResult = gridIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with DsGridIter column - FetchForEach - fetchForEach(call)");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["3", [0, 1], undefined], ["1", [1, 0], undefined], ["4", [1, 1], undefined], ["2", [2, 0], undefined], ["5", [2, 1], undefined]], "Core with DsGridIter column - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIterResult = gridIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsGridIter column - FetchForEach - fetchForEach(call, 3)");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["3", [0, 1], undefined], ["1", [1, 0], undefined]], "Core with DsGridIter column - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	gridIter = new DsGridIter(fixture22, true);
	gridIterResult = gridIter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with DsGridIter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(gridIterResult, [["0", [0, 0], undefined], ["2", [0, 1], undefined], ["1", [1, 0], undefined], ["3", [1, 1], undefined]], "Core with DsGridIter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	gridIter = new DsGridIter(fixture32, true);
	gridIterResult = gridIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsGridIter column - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(gridIterResult, [["0", [0, 0], 4321], ["3", [0, 1], 4321], ["1", [1, 0], 4321]], "Core with DsGridIter column - FetchForEach - fetchForEach(call, 3, 4321)");
	#endregion
	
	// Cleanup
	ds_grid_destroy(fixture32);
	ds_grid_destroy(fixture22);
}
