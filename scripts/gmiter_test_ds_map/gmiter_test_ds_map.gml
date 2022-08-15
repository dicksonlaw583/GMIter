///@func gmiter_test_ds_map()
function gmiter_test_ds_map(){
	var spy = new GMIterForEachSpy();
	var fixtures = [
		GMIterMap(),
		GMIterMap("a", 111),
		GMIterMap("a", 111, "b", 222),
		GMIterMap("a", 111, "b", 222, "c", 333),
		GMIterMap("a", 111, "b", 222, "c", 333, "d", 444),
	];
	var dsMapIter;
	
	#region Starting state
	dsMapIter = new DsMapIter(fixtures[0]);
	assert_equal(dsMapIter.index, undefined, "Core with DsMapIter - Starting state - Bad index for empty");
	assert_equal(dsMapIter.value, undefined, "Core with DsMapIter - Starting state - Bad value for empty");
	assert_equal(dsMapIter.getIndex(), undefined, "Core with DsMapIter - Starting state - Bad getIndex() for empty");
	assert_equal(dsMapIter.getValue(), undefined, "Core with DsMapIter - Starting state - Bad getValue() for empty");
	
	dsMapIter = new DsMapIter(fixtures[1]);
	assert_equal(dsMapIter.index, "a", "Core with DsMapIter - Starting state - Bad index for normal");
	assert_equal(dsMapIter.value, 111, "Core with DsMapIter - Starting state - Bad value for normal");
	assert_equal(dsMapIter.getIndex(), "a", "Core with DsMapIter - Starting state - Bad getIndex() for normal");
	assert_equal(dsMapIter.getValue(), 111, "Core with DsMapIter - Starting state - Bad getValue() for normal");
	#endregion
	
	#region Fetching
	dsMapIter = new DsMapIter(fixtures[3]);
	assert_equal(gmi_array_sorted(dsMapIter.fetch()), [111, 222, 333], "Core with DsMapIter - Fetching - Bad fetch()");
	dsMapIter = new DsMapIter(fixtures[2]);
	assert_equal(gmi_array_sorted(dsMapIter.fetch(3)), [111, 222], "Core with DsMapIter - Fetching - Bad fetch(3) overflowing");
	
	dsMapIter = new DsMapIter(fixtures[3]);
	assert_equal(gmi_array_sorted(dsMapIter.fetchIndices()), ["a", "b", "c"], "Core with DsMapIter - Fetching - Bad fetchIndices()");
	dsMapIter = new DsMapIter(fixtures[2]);
	assert_equal(gmi_array_sorted(dsMapIter.fetchIndices(3)), ["a", "b"], "Core with DsMapIter - Fetching - Bad fetchIndices(3) overflowing");
	
	dsMapIter = new DsMapIter(fixtures[3]);
	assert_equal(gmi_array_sorted_by_column(dsMapIter.fetchValueIndexArray(), 0), [[111, "a"], [222, "b"], [333, "c"]], "Core with DsMapIter - Fetching - Bad fetchValueIndexArray()");
	dsMapIter = new DsMapIter(fixtures[2]);
	assert_equal(gmi_array_sorted_by_column(dsMapIter.fetchValueIndexArray(3), 0), [[111, "a"], [222, "b"]], "Core with DsMapIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	dsMapIter = new DsMapIter(fixtures[3]);
	assert_equal(dsMapIter.fetchValueIndexStruct(), { a: 111, b: 222, c: 333 }, "Core with DsMapIter - Fetching - Bad fetchValueIndexStruct()");
	dsMapIter = new DsMapIter(fixtures[2]);
	assert_equal(dsMapIter.fetchValueIndexStruct(3), { a: 111, b: 222 }, "Core with DsMapIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[3]);
	dsMapIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DsMapIter - ForEach - Bad forEach(call)");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", undefined], [222, "b", undefined], [333, "c", undefined]], "Core with DsMapIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[1]);
	dsMapIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DsMapIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", undefined]], "Core with DsMapIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[3]);
	dsMapIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsMapIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", 4321], [222, "b", 4321], [333, "c", 4321]], "Core with DsMapIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var dsMapIterResult;
	
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[3]);
	dsMapIterResult = dsMapIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DsMapIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(gmi_array_sorted_by_column(dsMapIterResult, 0), [[111, "a", undefined], [222, "b", undefined], [333, "c", undefined]], "Core with DsMapIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[1]);
	dsMapIterResult = dsMapIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DsMapIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(gmi_array_sorted_by_column(dsMapIterResult, 0), [[111, "a", undefined]], "Core with DsMapIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	dsMapIter = new DsMapIter(fixtures[3]);
	dsMapIterResult = dsMapIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsMapIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(gmi_array_sorted_by_column(dsMapIterResult, 0), [[111, "a", 4321], [222, "b", 4321], [333, "c", 4321]], "Core with DsMapIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
	
	// Cleanup
	for (var i = array_length(fixtures)-1; i >= 0; --i) {
		ds_map_destroy(fixtures[i]);
	}
}
