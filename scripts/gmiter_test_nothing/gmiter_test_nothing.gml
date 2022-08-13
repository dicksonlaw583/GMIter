///@func gmiter_test_nothing()
function gmiter_test_nothing(){
	var spy = new GMIterForEachSpy();
	var nothingIter, nothingIterResult;
	
	#region Starting state
	nothingIter = new NothingIter();
	assert_is_undefined(nothingIter.index, "Core with NothingIter - Starting state - Bad index");
	assert_is_undefined(nothingIter.value, "Core with NothingIter - Starting state - Bad value");
	assert_is_undefined(nothingIter.getIndex(), "Core with NothingIter - Starting state - Bad getIndex()");
	assert_is_undefined(nothingIter.getValue(), "Core with NothingIter - Starting state - Bad getValue()");
	#endregion
	
	#region Fetching
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetch(), [], "Core with NothingIter - Fetching - Bad fetch()");
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetch(2), [], "Core with NothingIter - Fetching - Bad fetch(2)");
	
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchIndices(), [], "Core with NothingIter - Fetching - Bad fetchIndices()");
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchIndices(2), [], "Core with NothingIter - Fetching - Bad fetchIndices(2)");
	
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchValueIndexArray(), [], "Core with NothingIter - Fetching - Bad fetchValueIndexArray()");
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchValueIndexArray(2), [], "Core with NothingIter - Fetching - Bad fetchValueIndexArray(2)");
	
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchValueIndexStruct(), {}, "Core with NothingIter - Fetching - Bad fetchValueIndexStruct()");
	nothingIter = new NothingIter();
	assert_equal(nothingIter.fetchValueIndexStruct(2), {}, "Core with NothingIter - Fetching - Bad fetchValueIndexStruct(2)");
	#endregion
	
	#region ForEach
	spy.reset();
	nothingIter = new NothingIter();
	nothingIter.forEach(spy.call);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [], "Core with NothingIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	nothingIter = new NothingIter();
	nothingIter.forEach(spy.call, 4);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad forEach(call, 4)");
	assert_equal(spy.calls, [], "Core with NothingIter - ForEach - Bad forEach(call, 4)");
	
	spy.reset();
	nothingIter = new NothingIter();
	nothingIter.forEach(spy.call, 4, 4321);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad forEach(call, 4, 4321)");
	assert_equal(spy.calls, [], "Core with NothingIter - ForEach - Bad forEach(call, 4, 4321)");
	
	spy.reset();
	nothingIter = new NothingIter();
	nothingIterResult = nothingIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad fetchForEach(call)");
	assert_equal(nothingIterResult, [], "Core with NothingIter - ForEach - Bad fetchForEach(call)");
	
	spy.reset();
	nothingIter = new NothingIter();
	nothingIterResult = nothingIter.fetchForEach(spy.call, 4);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad fetchForEach(call, 4)");
	assert_equal(nothingIterResult, [], "Core with NothingIter - ForEach - Bad fetchForEach(call, 4)");
	
	spy.reset();
	nothingIter = new NothingIter();
	nothingIterResult = nothingIter.fetchForEach(spy.call, 4, 4321);
	assert_equal(spy.count(), 0, "Core with NothingIter - ForEach - Bad fetchForEach(call, 4, 4321)");
	assert_equal(nothingIterResult, [], "Core with NothingIter - ForEach - Bad fetchForEach(call, 4, 4321)");
	#endregion
}
