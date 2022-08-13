///@func gmiter_test_times()
function gmiter_test_times(){
	var spy = new GMIterForEachSpy();
	var timesIter;
	
	#region Starting state
	timesIter = new TimesIter(3);
	assert_equal(timesIter.index, 0, "Core with TimesIter - Starting state - Bad index");
	assert_equal(timesIter.value, 0, "Core with TimesIter - Starting state - Bad value");
	assert_equal(timesIter.getIndex(), 0, "Core with TimesIter - Starting state - Bad getIndex()");
	assert_equal(timesIter.getValue(), 0, "Core with TimesIter - Starting state - Bad getValue()");
	#endregion
	
	#region Fetching
	timesIter = new TimesIter(3);
	assert_equal(timesIter.fetch(), [0, 1, 2], "Core with TimesIter - Fetching - Bad fetch()");
	timesIter = new TimesIter();
	assert_equal(timesIter.fetch(2), [0, 1], "Core with TimesIter - Fetching - Bad fetch(2)");
	timesIter = new TimesIter(2);
	assert_equal(timesIter.fetch(3), [0, 1], "Core with TimesIter - Fetching - Bad fetch(3) overflowing");
	
	timesIter = new TimesIter(3);
	assert_equal(timesIter.fetchIndices(), [0, 1, 2], "Core with TimesIter - Fetching - Bad fetchIndices()");
	timesIter = new TimesIter();
	assert_equal(timesIter.fetchIndices(2), [0, 1], "Core with TimesIter - Fetching - Bad fetchIndices(2)");
	timesIter = new TimesIter(2);
	assert_equal(timesIter.fetchIndices(3), [0, 1], "Core with TimesIter - Fetching - Bad fetchIndices(3) overflowing");
	
	timesIter = new TimesIter(3);
	assert_equal(timesIter.fetchValueIndexArray(), [[0, 0], [1, 1], [2, 2]], "Core with TimesIter - Fetching - Bad fetchValueIndexArray()");
	timesIter = new TimesIter();
	assert_equal(timesIter.fetchValueIndexArray(2), [[0, 0], [1, 1]], "Core with TimesIter - Fetching - Bad fetchValueIndexArray(2)");
	timesIter = new TimesIter(2);
	assert_equal(timesIter.fetchValueIndexArray(3), [[0, 0], [1, 1]], "Core with TimesIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	timesIter = new TimesIter(3);
	assert_equal(timesIter.fetchValueIndexStruct(), GMIterStruct("0", 0, "1", 1, "2", 2), "Core with TimesIter - Fetching - Bad fetchValueIndexStruct()");
	timesIter = new TimesIter();
	assert_equal(timesIter.fetchValueIndexStruct(2), GMIterStruct("0", 0, "1", 1), "Core with TimesIter - Fetching - Bad fetchValueIndexStruct(2)");
	timesIter = new TimesIter(2);
	assert_equal(timesIter.fetchValueIndexStruct(3), GMIterStruct("0", 0, "1", 1), "Core with TimesIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	timesIter = new TimesIter(3);
	timesIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with TimesIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[0, 0, undefined], [1, 1, undefined], [2, 2, undefined]], "Core with TimesIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	timesIter = new TimesIter();
	timesIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with TimesIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[0, 0, undefined], [1, 1, undefined], [2, 2, undefined]], "Core with TimesIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	timesIter = new TimesIter(1);
	timesIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with TimesIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[0, 0, undefined]], "Core with TimesIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	timesIter = new TimesIter();
	timesIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with TimesIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[0, 0, 4321], [1, 1, 4321], [2, 2, 4321]], "Core with TimesIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var timesIterResult;
	
	spy.reset();
	timesIter = new TimesIter(3);
	timesIterResult = timesIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with TimesIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(timesIterResult, [[0, 0, undefined], [1, 1, undefined], [2, 2, undefined]], "Core with TimesIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	timesIter = new TimesIter();
	timesIterResult = timesIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(timesIterResult, [[0, 0, undefined], [1, 1, undefined], [2, 2, undefined]], "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	timesIter = new TimesIter(1);
	timesIterResult = timesIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(timesIterResult, [[0, 0, undefined]], "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	timesIter = new TimesIter();
	timesIterResult = timesIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(timesIterResult, [[0, 0, 4321], [1, 1, 4321], [2, 2, 4321]], "Core with TimesIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
