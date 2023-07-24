///@func gmiter_test_zip()
function gmiter_test_zip(){
	var spy = new GMIterForEachSpy();
	var zipIter;
	
	#region Starting state
	zipIter = new ZipIter();
	assert_equal(zipIter.index, [], "Core with ZipIter - Starting state - Bad index for empty");
	assert_equal(zipIter.value, [], "Core with ZipIter - Starting state - Bad value for empty");
	assert_equal(zipIter.getIndex(), [], "Core with ZipIter - Starting state - Bad getIndex() for empty");
	assert_equal(zipIter.getValue(), [], "Core with ZipIter - Starting state - Bad getValue() for empty");
	
	zipIter = new ZipIter(new ArrayIter(["foo", "FOO"]), new ArrayIter(["bar", "BAR"]));
	assert_equal(zipIter.index, [0, 0], "Core with ZipIter - Starting state - index for normal");
	assert_equal(zipIter.value, ["foo", "bar"], "Core with ZipIter - Starting state - value for normal");
	assert_equal(zipIter.getIndex(), [0, 0], "Core with ZipIter - Starting state - getIndex() for normal");
	assert_equal(zipIter.getValue(), ["foo", "bar"], "Core with ZipIter - Starting state - getValue() for normal");
	exit;
	#endregion
	
	#region Fetching
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetch(), [[11, 111], [22, 222], [33, 333]], "Core with ZipIter - Fetching - Bad fetch()");
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetch(2), [[11, 111], [22, 222]], "Core with ZipIter - Fetching - Bad fetch(2)");
	zipIter = new ZipIter(new ArrayIter([11, 22, 99]), new ArrayIter([111, 222]));
	assert_equal(zipIter.fetch(3), [[11, 111], [22, 222]], "Core with ZipIter - Fetching - Bad fetch(3) overflowing");
	
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchIndices(), [[0, 0], [1, 1], [2, 2]], "Core with ZipIter - Fetching - Bad fetchIndices()");
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchIndices(2), [[0, 0], [1, 1]], "Core with ZipIter - Fetching - Bad fetchIndices(2)");
	zipIter = new ZipIter(new ArrayIter([11, 22, 99]), new ArrayIter([111, 222]));
	assert_equal(zipIter.fetchIndices(3), [[0, 0], [1, 1]], "Core with ZipIter - Fetching - Bad fetchIndices(3) overflowing");
	
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchValueIndexArray(), [[[11, 111], [0, 0]], [[22, 222], [1, 1]], [[33, 333], [2, 2]]], "Core with ZipIter - Fetching - Bad fetchValueIndexArray()");
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchValueIndexArray(2), [[[11, 111], [0, 0]], [[22, 222], [1, 1]]], "Core with ZipIter - Fetching - Bad fetchValueIndexArray(2)");
	zipIter = new ZipIter(new ArrayIter([11, 22, 99]), new ArrayIter([111, 222]));
	assert_equal(zipIter.fetchValueIndexArray(3), [[[11, 111], [0, 0]], [[22, 222], [1, 1]]], "Core with ZipIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchValueIndexStruct(), GMIterStruct([0, 0], [11, 111], [1, 1], [22, 222], [2, 2], [33, 333]), "Core with ZipIter - Fetching - Bad fetchValueIndexStruct()");
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	assert_equal(zipIter.fetchValueIndexStruct(2), GMIterStruct([0, 0], [11, 111], [1, 1], [22, 222]), "Core with ZipIter - Fetching - Bad fetchValueIndexStruct(2)");
	zipIter = new ZipIter(new ArrayIter([11, 22, 99]), new ArrayIter([111, 222]));
	assert_equal(zipIter.fetchValueIndexStruct(3), GMIterStruct([0, 0], [11, 111], [1, 1], [22, 222]), "Core with ZipIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	zipIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ZipIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[[11, 111], [0, 0], undefined], [[22, 222], [1, 1], undefined], [[33, 333], [2, 2], undefined]], "Core with ZipIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33, 44]), new ArrayIter([111, 222, 333, 444]));
	zipIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ZipIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[[11, 111], [0, 0], undefined], [[22, 222], [1, 1], undefined], [[33, 333], [2, 2], undefined]], "Core with ZipIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11]), new ArrayIter([111, 999]));
	zipIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ZipIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[[11, 111], [0, 0], undefined]], "Core with ZipIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	zipIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ZipIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[[11, 111], [0, 0], 4321], [[22, 222], [1, 1], 4321], [[33, 333], [2, 2], 4321]], "Core with ZipIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var zipIterResult;
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	zipIterResult = zipIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with ZipIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(zipIterResult, [[[11, 111], [0, 0], undefined], [[22, 222], [1, 1], undefined], [[33, 333], [2, 2], undefined]], "Core with ZipIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33, 44]), new ArrayIter([111, 222, 333, 444]));
	zipIterResult = zipIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(zipIterResult, [[[11, 111], [0, 0], undefined], [[22, 222], [1, 1], undefined], [[33, 333], [2, 2], undefined]], "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11]), new ArrayIter([111, 999]));
	zipIterResult = zipIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(zipIterResult, [[[11, 111], [0, 0], undefined]], "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	zipIter = new ZipIter(new ArrayIter([11, 22, 33]), new ArrayIter([111, 222, 333]));
	zipIterResult = zipIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(zipIterResult, [[[11, 111], [0, 0], 4321], [[22, 222], [1, 1], 4321], [[33, 333], [2, 2], 4321]], "Core with ZipIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
