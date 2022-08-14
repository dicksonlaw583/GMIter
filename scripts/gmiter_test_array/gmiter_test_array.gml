///@func gmiter_test_array()
function gmiter_test_array(){
	var spy = new GMIterForEachSpy();
	var arrayIter;
	
	#region Starting state
	arrayIter = new ArrayIter([]);
	assert_equal(arrayIter.index, 0, "Core with ArrayIter - Starting state - Bad index for empty");
	assert_equal(arrayIter.value, undefined, "Core with ArrayIter - Starting state - Bad value for empty");
	assert_equal(arrayIter.getIndex(), 0, "Core with ArrayIter - Starting state - Bad getIndex() for empty");
	assert_equal(arrayIter.getValue(), undefined, "Core with ArrayIter - Starting state - Bad getValue() for empty");
	
	arrayIter = new ArrayIter(["foo"]);
	assert_equal(arrayIter.index, 0, "Core with ArrayIter - Starting state - Bad index for normal");
	assert_equal(arrayIter.value, "foo", "Core with ArrayIter - Starting state - Bad value for normal");
	assert_equal(arrayIter.getIndex(), 0, "Core with ArrayIter - Starting state - Bad getIndex() for normal");
	assert_equal(arrayIter.getValue(), "foo", "Core with ArrayIter - Starting state - Bad getValue() for normal");
	#endregion
	
	#region Fetching
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetch(), [111, 222, 333], "Core with ArrayIter - Fetching - Bad fetch()");
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetch(2), [111, 222], "Core with ArrayIter - Fetching - Bad fetch(2)");
	arrayIter = new ArrayIter([111, 222]);
	assert_equal(arrayIter.fetch(3), [111, 222], "Core with ArrayIter - Fetching - Bad fetch(3) overflowing");
	
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchIndices(), [0, 1, 2], "Core with ArrayIter - Fetching - Bad fetchIndices()");
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchIndices(2), [0, 1], "Core with ArrayIter - Fetching - Bad fetchIndices(2)");
	arrayIter = new ArrayIter([111, 222]);
	assert_equal(arrayIter.fetchIndices(3), [0, 1], "Core with ArrayIter - Fetching - Bad fetchIndices(3) overflowing");
	
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchValueIndexArray(), [[111, 0], [222, 1], [333, 2]], "Core with ArrayIter - Fetching - Bad fetchValueIndexArray()");
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchValueIndexArray(2), [[111, 0], [222, 1]], "Core with ArrayIter - Fetching - Bad fetchValueIndexArray(2)");
	arrayIter = new ArrayIter([111, 222]);
	assert_equal(arrayIter.fetchValueIndexArray(3), [[111, 0], [222, 1]], "Core with ArrayIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchValueIndexStruct(), GMIterStruct("0", 111, "1", 222, "2", 333), "Core with ArrayIter - Fetching - Bad fetchValueIndexStruct()");
	arrayIter = new ArrayIter([111, 222, 333]);
	assert_equal(arrayIter.fetchValueIndexStruct(2), GMIterStruct("0", 111, "1", 222), "Core with ArrayIter - Fetching - Bad fetchValueIndexStruct(2)");
	arrayIter = new ArrayIter([111, 222]);
	assert_equal(arrayIter.fetchValueIndexStruct(3), GMIterStruct("0", 111, "1", 222), "Core with ArrayIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333]);
	arrayIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ArrayIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with ArrayIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333, 444]);
	arrayIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ArrayIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with ArrayIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	arrayIter = new ArrayIter([111]);
	arrayIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ArrayIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[111, 0, undefined]], "Core with ArrayIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333]);
	arrayIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ArrayIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with ArrayIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var arrayIterResult;
	
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333]);
	arrayIterResult = arrayIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ArrayIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(arrayIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with ArrayIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333, 444]);
	arrayIterResult = arrayIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(arrayIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	arrayIter = new ArrayIter([111]);
	arrayIterResult = arrayIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(arrayIterResult, [[111, 0, undefined]], "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	arrayIter = new ArrayIter([111, 222, 333]);
	arrayIterResult = arrayIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(arrayIterResult, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with ArrayIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
