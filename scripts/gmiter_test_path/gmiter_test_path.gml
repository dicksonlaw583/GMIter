///@func gmiter_test_path()
function gmiter_test_path(){
	var spy = new GMIterForEachSpy();
	var iter;

	#region Starting state
	iter = new PathIter(gmiter_test_path_fixture, 0);
	assert_equal(iter.index, [0, 0], "Core with PathIter - Starting state - Bad index for empty");
	assert_equal(iter.value, [1, 3], "Core with PathIter - Starting state - Bad value for empty");
	assert_equal(iter.getIndex(), [0, 0], "Core with PathIter - Starting state - Bad getIndex() for empty");
	assert_equal(iter.getValue(), [1, 3], "Core with PathIter - Starting state - Bad getValue() for empty");
	
	iter = new PathIter(gmiter_test_path_fixture, 4);
	assert_equal(iter.index, [0, 0], "Core with PathIter - Starting state - Bad index for normal");
	assert_equal(iter.value, [1, 3], "Core with PathIter - Starting state - Bad value for normal");
	assert_equal(iter.getIndex(), [0, 0], "Core with PathIter - Starting state - Bad getIndex() for normal");
	assert_equal(iter.getValue(), [1, 3], "Core with PathIter - Starting state - Bad getValue() for normal");
	#endregion

	#region Fetching
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetch(), [[1, 3], [7, 15], [13, 27]], "Core with PathIter - Fetching - Bad fetch()");
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetch(2), [[1, 3], [7, 15]], "Core with PathIter - Fetching - Bad fetch(2)");
	iter = new PathIter(gmiter_test_path_fixture, 2);
	assert_equal(iter.fetch(3), [[1, 3], [13, 27]], "Core with PathIter - Fetching - Bad fetch(3) overflowing");
	
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchIndices(), [[0, 0], [1, 0.5], [2, 1]], "Core with PathIter - Fetching - Bad fetchIndices()");
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchIndices(2), [[0, 0], [1, 0.5]], "Core with PathIter - Fetching - Bad fetchIndices(2)");
	iter = new PathIter(gmiter_test_path_fixture, 2);
	assert_equal(iter.fetchIndices(3), [[0, 0], [1, 1]], "Core with PathIter - Fetching - Bad fetchIndices(3) overflowing");
	
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchValueIndexArray(), [[[1, 3], [0, 0]], [[7, 15], [1, 0.5]], [[13, 27], [2, 1]]], "Core with PathIter - Fetching - Bad fetchValueIndexArray()");
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchValueIndexArray(2), [[[1, 3], [0, 0]], [[7, 15], [1, 0.5]]], "Core with PathIter - Fetching - Bad fetchValueIndexArray(2)");
	iter = new PathIter(gmiter_test_path_fixture, 2);
	assert_equal(iter.fetchValueIndexArray(3), [[[1, 3], [0, 0]], [[13, 27], [1, 1]]], "Core with PathIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], [1, 3], [1, 0.5], [7, 15], [2, 1], [13, 27]), "Core with PathIter - Fetching - Bad fetchValueIndexStruct()");
	iter = new PathIter(gmiter_test_path_fixture, 3);
	assert_equal(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], [1, 3], [1, 0.5], [7, 15]), "Core with PathIter - Fetching - Bad fetchValueIndexStruct(2)");
	iter = new PathIter(gmiter_test_path_fixture, 2);
	assert_equal(iter.fetchValueIndexStruct(3), GMIterStruct([0, 0], [1, 3], [1, 1], [13, 27]), "Core with PathIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 3);
	iter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with PathIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[[1, 3], [0, 0], undefined], [[7, 15], [1, 0.5], undefined], [[13, 27], [2, 1], undefined]], "Core with PathIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 4);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with PathIter - ForEach - Bad forEach(call, 3)");
	assert_equalish(spy.calls, [[[1, 3], [0, 0], undefined], [[5, 11], [1, 1/3], undefined], [[9, 19], [2, 2/3], undefined]], "Core with PathIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 1);
	iter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with PathIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[[1, 3], [0, 0], undefined]], "Core with PathIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 3);
	iter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with PathIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[[1, 3], [0, 0], 4321], [[7, 15], [1, 0.5], 4321], [[13, 27], [2, 1], 4321]], "Core with PathIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var PathIterResult;
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 3);
	PathIterResult = iter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with PathIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(PathIterResult, [[[1, 3], [0, 0], undefined], [[7, 15], [1, 0.5], undefined], [[13, 27], [2, 1], undefined]], "Core with PathIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 4);
	PathIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equalish(PathIterResult, [[[1, 3], [0, 0], undefined], [[5, 11], [1, 1/3], undefined], [[9, 19], [2, 2/3], undefined]], "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 1);
	PathIterResult = iter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(PathIterResult, [[[1, 3], [0, 0], undefined]], "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new PathIter(gmiter_test_path_fixture, 3);
	PathIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(PathIterResult, [[[1, 3], [0, 0], 4321], [[7, 15], [1, 0.5], 4321], [[13, 27], [2, 1], 4321]], "Core with PathIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
