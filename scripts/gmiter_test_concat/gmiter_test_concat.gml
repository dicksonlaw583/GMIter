///@func gmiter_test_concat()
function gmiter_test_concat(){
	var spy = new GMIterForEachSpy();
	var concatIter;
	
	#region Starting state
	concatIter = new ConcatIter(new ArrayIter([]), new TimesIter(0));
	assert_equal(concatIter.index, undefined, "Core with ConcatIter - Starting state - Bad index for empty");
	assert_equal(concatIter.value, undefined, "Core with ConcatIter - Starting state - Bad value for empty");
	assert_equal(concatIter.getIndex(), undefined, "Core with ConcatIter - Starting state - Bad getIndex() for empty");
	assert_equal(concatIter.getValue(), undefined, "Core with ConcatIter - Starting state - Bad getValue() for empty");
	
	concatIter = new ConcatIter(new ArrayIter(["foo"]));
	assert_equal(concatIter.index, 0, "Core with ConcatIter - Starting state - Bad index for normal");
	assert_equal(concatIter.value, "foo", "Core with ConcatIter - Starting state - Bad value for normal");
	assert_equal(concatIter.getIndex(), 0, "Core with ConcatIter - Starting state - Bad getIndex() for normal");
	assert_equal(concatIter.getValue(), "foo", "Core with ConcatIter - Starting state - Bad getValue() for normal");
	
	concatIter = new ConcatIter(new TimesIter(0), new ArrayIter(["foo"]), new DroneIter("no"));
	assert_equal(concatIter.index, 0, "Core with ConcatIter - Starting state with skip - Bad index for normal");
	assert_equal(concatIter.value, "foo", "Core with ConcatIter - Starting state with skip - Bad value for normal");
	assert_equal(concatIter.getIndex(), 0, "Core with ConcatIter - Starting state with skip- Bad getIndex() for normal");
	assert_equal(concatIter.getValue(), "foo", "Core with ConcatIter - Starting state with skip - Bad getValue() for normal");
	#endregion
	
	#region Fetching
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetch(), [111, 222, 333], "Core with ConcatIter - Fetching - Bad fetch()");
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetch(2), [111, 222], "Core with ConcatIter - Fetching - Bad fetch(2)");
	concatIter = new ConcatIter(new ArrayIter([111]), new ArrayIter([222]));
	assert_equal(concatIter.fetch(3), [111, 222], "Core with ConcatIter - Fetching - Bad fetch(3) overflowing");
	
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchIndices(), [0, 1, 0], "Core with ConcatIter - Fetching - Bad fetchIndices()");
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchIndices(2), [0, 1], "Core with ConcatIter - Fetching - Bad fetchIndices(2)");
	concatIter = new ConcatIter(new ArrayIter([111]), new ArrayIter([222]));
	assert_equal(concatIter.fetchIndices(3), [0, 0], "Core with ConcatIter - Fetching - Bad fetchIndices(3) overflowing");
	
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchValueIndexArray(), [[111, 0], [222, 1], [333, 0]], "Core with ConcatIter - Fetching - Bad fetchValueIndexArray()");
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchValueIndexArray(2), [[111, 0], [222, 1]], "Core with ConcatIter - Fetching - Bad fetchValueIndexArray(2)");
	concatIter = new ConcatIter(new ArrayIter([111]), new ArrayIter([222]));
	assert_equal(concatIter.fetchValueIndexArray(3), [[111, 0], [222, 0]], "Core with ConcatIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchValueIndexStruct(), GMIterStruct("0", 111, "1", 222, "0", 333), "Core with ConcatIter - Fetching - Bad fetchValueIndexStruct()");
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	assert_equal(concatIter.fetchValueIndexStruct(2), GMIterStruct("0", 111, "1", 222), "Core with ConcatIter - Fetching - Bad fetchValueIndexStruct(2)");
	concatIter = new ConcatIter(new ArrayIter([111]), new ArrayIter([222]));
	assert_equal(concatIter.fetchValueIndexStruct(3), GMIterStruct("0", 111, "0", 222), "Core with ConcatIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	concatIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ConcatIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 0, undefined]], "Core with ConcatIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333, 444]));
	concatIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ConcatIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[111, 0, undefined], [222, 1, undefined], [333, 0, undefined]], "Core with ConcatIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111]));
	concatIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ConcatIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[111, 0, undefined]], "Core with ConcatIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	concatIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ConcatIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[111, 0, 4321], [222, 1, 4321], [333, 0, 4321]], "Core with ConcatIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var concatIterResult;
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	concatIterResult = concatIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ConcatIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(concatIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 0, undefined]], "Core with ConcatIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333, 444]));
	concatIterResult = concatIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(concatIterResult, [[111, 0, undefined], [222, 1, undefined], [333, 0, undefined]], "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111]));
	concatIterResult = concatIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(concatIterResult, [[111, 0, undefined]], "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	concatIter = new ConcatIter(new ArrayIter([111, 222]), new ArrayIter([333]));
	concatIterResult = concatIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(concatIterResult, [[111, 0, 4321], [222, 1, 4321], [333, 0, 4321]], "Core with ConcatIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
