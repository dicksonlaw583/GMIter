///@func gmiter_test_ds_list()
function gmiter_test_ds_list(){
	var spy = new GMIterForEachSpy();
	var fixtures = [
		GMIterList(),
		GMIterList(111),
		GMIterList(111, 222),
		GMIterList(111, 222, 333),
		GMIterList(111, 222, 333, 444),
	];
	var dsListIter;
	
	#region Starting state
	dsListIter = new DsListIter(fixtures[0]);
	assert_equal(dsListIter.index, 0, "Core with DsListIter - Starting state - Bad index for empty");
	assert_equal(dsListIter.value, undefined, "Core with DsListIter - Starting state - Bad value for empty");
	assert_equal(dsListIter.getIndex(), 0, "Core with DsListIter - Starting state - Bad getIndex() for empty");
	assert_equal(dsListIter.getValue(), undefined, "Core with DsListIter - Starting state - Bad getValue() for empty");
	
	dsListIter = new DsListIter(fixtures[1]);
	assert_equal(dsListIter.index, 0, "Core with DsListIter - Starting state - Bad index for normal");
	assert_equal(dsListIter.value, 111, "Core with DsListIter - Starting state - Bad value for normal");
	assert_equal(dsListIter.getIndex(), 0, "Core with DsListIter - Starting state - Bad getIndex() for normal");
	assert_equal(dsListIter.getValue(), 111, "Core with DsListIter - Starting state - Bad getValue() for normal");
	#endregion
	
	#region Fetching
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetch(), [111, 222, 333], "Core with DsListIter - Fetching - Bad fetch()");
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetch(2), [111, 222], "Core with DsListIter - Fetching - Bad fetch(2)");
	dsListIter = new DsListIter(fixtures[2]);
	assert_equal(dsListIter.fetch(3), [111, 222], "Core with DsListIter - Fetching - Bad fetch(3) overflowing");
	
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchIndices(), [0, 1, 2], "Core with DsListIter - Fetching - Bad fetchIndices()");
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchIndices(2), [0, 1], "Core with DsListIter - Fetching - Bad fetchIndices(2)");
	dsListIter = new DsListIter(fixtures[2]);
	assert_equal(dsListIter.fetchIndices(3), [0, 1], "Core with DsListIter - Fetching - Bad fetchIndices(3) overflowing");
	
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchValueIndexArray(), [[111, 0], [222, 1], [333, 2]], "Core with DsListIter - Fetching - Bad fetchValueIndexArray()");
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchValueIndexArray(2), [[111, 0], [222, 1]], "Core with DsListIter - Fetching - Bad fetchValueIndexArray(2)");
	dsListIter = new DsListIter(fixtures[2]);
	assert_equal(dsListIter.fetchValueIndexArray(3), [[111, 0], [222, 1]], "Core with DsListIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchValueIndexStruct(), GMIterStruct("0", 111, "1", 222, "2", 333), "Core with DsListIter - Fetching - Bad fetchValueIndexStruct()");
	dsListIter = new DsListIter(fixtures[3]);
	assert_equal(dsListIter.fetchValueIndexStruct(2), GMIterStruct("0", 111, "1", 222), "Core with DsListIter - Fetching - Bad fetchValueIndexStruct(2)");
	dsListIter = new DsListIter(fixtures[2]);
	assert_equal(dsListIter.fetchValueIndexStruct(3), GMIterStruct("0", 111, "1", 222), "Core with DsListIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	dsListIter = new DsListIter(fixtures[3]);
	dsListIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DsListIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with DsListIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[4]);
	dsListIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsListIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with DsListIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[1]);
	dsListIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DsListIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[111, 0, undefined]], "Core with DsListIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[3]);
	dsListIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsListIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with DsListIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var dsListIterResult;
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[3]);
	dsListIterResult = dsListIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DsListIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(dsListIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with DsListIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[4]);
	dsListIterResult = dsListIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(dsListIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[1]);
	dsListIterResult = dsListIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(dsListIterResult, [[111, 0, undefined]], "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	dsListIter = new DsListIter(fixtures[3]);
	dsListIterResult = dsListIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(dsListIterResult, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with DsListIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
