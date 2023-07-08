///@func gmiter_test_range()
function gmiter_test_range(){
	var spy = new GMIterForEachSpy();
	var iter;

	#region Starting state
	iter = new RangeIter(1, 0);
	assert_equal(iter.index, 0, "Core with RangeIter - Starting state - Bad index for empty");
	assert_equal(iter.value, 1, "Core with RangeIter - Starting state - Bad value for empty");
	assert_equal(iter.getIndex(), 0, "Core with RangeIter - Starting state - Bad getIndex() for empty");
	assert_equal(iter.getValue(), 1, "Core with RangeIter - Starting state - Bad getValue() for empty");
	
	iter = new RangeIter(1, 3);
	assert_equal(iter.index, 0, "Core with RangeIter - Starting state - Bad index for normal");
	assert_equal(iter.value, 1, "Core with RangeIter - Starting state - Bad value for normal");
	assert_equal(iter.getIndex(), 0, "Core with RangeIter - Starting state - Bad getIndex() for normal");
	assert_equal(iter.getValue(), 1, "Core with RangeIter - Starting state - Bad getValue() for normal");
	#endregion

	#region Fetching
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetch(), [111, 222, 333], "Core with RangeIter - Fetching - Bad fetch()");
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetch(2), [111, 222], "Core with RangeIter - Fetching - Bad fetch(2)");
	iter = new RangeIter(111, 230, 111);
	assert_equal(iter.fetch(3), [111, 222], "Core with RangeIter - Fetching - Bad fetch(3) overflowing");
	
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchIndices(), [0, 1, 2], "Core with RangeIter - Fetching - Bad fetchIndices()");
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchIndices(2), [0, 1], "Core with RangeIter - Fetching - Bad fetchIndices(2)");
	iter = new RangeIter(111, 230, 111);
	assert_equal(iter.fetchIndices(3), [0, 1], "Core with RangeIter - Fetching - Bad fetchIndices(3) overflowing");
	
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchValueIndexArray(), [[111, 0], [222, 1], [333, 2]], "Core with RangeIter - Fetching - Bad fetchValueIndexArray()");
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchValueIndexArray(2), [[111, 0], [222, 1]], "Core with RangeIter - Fetching - Bad fetchValueIndexArray(2)");
	iter = new RangeIter(111, 230, 111);
	assert_equal(iter.fetchValueIndexArray(3), [[111, 0], [222, 1]], "Core with RangeIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchValueIndexStruct(), GMIterStruct("0", 111, "1", 222, "2", 333), "Core with RangeIter - Fetching - Bad fetchValueIndexStruct()");
	iter = new RangeIter(111, 340, 111);
	assert_equal(iter.fetchValueIndexStruct(2), GMIterStruct("0", 111, "1", 222), "Core with RangeIter - Fetching - Bad fetchValueIndexStruct(2)");
	iter = new RangeIter(111, 230, 111);
	assert_equal(iter.fetchValueIndexStruct(3), GMIterStruct("0", 111, "1", 222), "Core with RangeIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	iter = new RangeIter(111, 340, 111);
	iter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with RangeIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with RangeIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	iter = new RangeIter(111, 445, 111);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with RangeIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with RangeIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	iter = new RangeIter(111, 112);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with RangeIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[111, 0, undefined]], "Core with RangeIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new RangeIter(111, 340, 111);
	iter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with RangeIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with RangeIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var RangeIterResult;
	
	spy.reset();
	iter = new RangeIter(111, 340, 111);
	RangeIterResult = iter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with RangeIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(RangeIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with RangeIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	iter = new RangeIter(111, 445, 111);
	RangeIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(RangeIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 2, undefined]], "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	iter = new RangeIter(111, 112);
	RangeIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(RangeIterResult, [[111, 0, undefined]], "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new RangeIter(111, 340, 111);
	RangeIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(RangeIterResult, [[111, 0, 4321], [222, 1, 4321], [333, 2, 4321]], "Core with RangeIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
