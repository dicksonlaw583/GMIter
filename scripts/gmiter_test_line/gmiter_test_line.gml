///@func gmiter_test_line()
function gmiter_test_line(){
	var spy = new GMIterForEachSpy();
	var iter;

	#region Starting state
	iter = new LineIter(1, 3, 13, 27, 0);
	assert_equal(iter.index, [0, 0], "Core with LineIter - Starting state - Bad index for empty");
	assert_equal(iter.value, [1, 3], "Core with LineIter - Starting state - Bad value for empty");
	assert_equal(iter.getIndex(), [0, 0], "Core with LineIter - Starting state - Bad getIndex() for empty");
	assert_equal(iter.getValue(), [1, 3], "Core with LineIter - Starting state - Bad getValue() for empty");
	
	iter = new LineIter(1, 3, 13, 27, 4);
	assert_equal(iter.index, [0, 0], "Core with LineIter - Starting state - Bad index for normal");
	assert_equal(iter.value, [1, 3], "Core with LineIter - Starting state - Bad value for normal");
	assert_equal(iter.getIndex(), [0, 0], "Core with LineIter - Starting state - Bad getIndex() for normal");
	assert_equal(iter.getValue(), [1, 3], "Core with LineIter - Starting state - Bad getValue() for normal");
	#endregion

	#region Fetching
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetch(), [[1, 3], [7, 15], [13, 27]], "Core with LineIter - Fetching - Bad fetch()");
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetch(2), [[1, 3], [7, 15]], "Core with LineIter - Fetching - Bad fetch(2)");
	iter = new LineIter(1, 3, 13, 27, 2);
	assert_equal(iter.fetch(3), [[1, 3], [13, 27]], "Core with LineIter - Fetching - Bad fetch(3) overflowing");
	
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchIndices(), [[0, 0], [1, 0.5], [2, 1]], "Core with LineIter - Fetching - Bad fetchIndices()");
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchIndices(2), [[0, 0], [1, 0.5]], "Core with LineIter - Fetching - Bad fetchIndices(2)");
	iter = new LineIter(1, 3, 13, 27, 2);
	assert_equal(iter.fetchIndices(3), [[0, 0], [1, 1]], "Core with LineIter - Fetching - Bad fetchIndices(3) overflowing");
	
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchValueIndexArray(), [[[1, 3], [0, 0]], [[7, 15], [1, 0.5]], [[13, 27], [2, 1]]], "Core with LineIter - Fetching - Bad fetchValueIndexArray()");
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchValueIndexArray(2), [[[1, 3], [0, 0]], [[7, 15], [1, 0.5]]], "Core with LineIter - Fetching - Bad fetchValueIndexArray(2)");
	iter = new LineIter(1, 3, 13, 27, 2);
	assert_equal(iter.fetchValueIndexArray(3), [[[1, 3], [0, 0]], [[13, 27], [1, 1]]], "Core with LineIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], [1, 3], [1, 0.5], [7, 15], [2, 1], [13, 27]), "Core with LineIter - Fetching - Bad fetchValueIndexStruct()");
	iter = new LineIter(1, 3, 13, 27, 3);
	assert_equal(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], [1, 3], [1, 0.5], [7, 15]), "Core with LineIter - Fetching - Bad fetchValueIndexStruct(2)");
	iter = new LineIter(1, 3, 13, 27, 2);
	assert_equal(iter.fetchValueIndexStruct(3), GMIterStruct([0, 0], [1, 3], [1, 1], [13, 27]), "Core with LineIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 3);
	iter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with LineIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[[1, 3], [0, 0], undefined], [[7, 15], [1, 0.5], undefined], [[13, 27], [2, 1], undefined]], "Core with LineIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 4);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LineIter - ForEach - Bad forEach(call, 3)");
	assert_equalish(spy.calls, [[[1, 3], [0, 0], undefined], [[5, 11], [1, 1/3], undefined], [[9, 19], [2, 2/3], undefined]], "Core with LineIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 1);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with LineIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[[1, 3], [0, 0], undefined]], "Core with LineIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 3);
	iter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LineIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[[1, 3], [0, 0], 4321], [[7, 15], [1, 0.5], 4321], [[13, 27], [2, 1], 4321]], "Core with LineIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var LineIterResult;
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 3);
	LineIterResult = iter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with LineIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(LineIterResult, [[[1, 3], [0, 0], undefined], [[7, 15], [1, 0.5], undefined], [[13, 27], [2, 1], undefined]], "Core with LineIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 4);
	LineIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equalish(LineIterResult, [[[1, 3], [0, 0], undefined], [[5, 11], [1, 1/3], undefined], [[9, 19], [2, 2/3], undefined]], "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 1);
	LineIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(LineIterResult, [[[1, 3], [0, 0], undefined]], "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new LineIter(1, 3, 13, 27, 3);
	LineIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(LineIterResult, [[[1, 3], [0, 0], 4321], [[7, 15], [1, 0.5], 4321], [[13, 27], [2, 1], 4321]], "Core with LineIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
