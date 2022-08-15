///@func gmiter_test_struct()
function gmiter_test_struct(){
	var spy = new GMIterForEachSpy();
	var structIter;
	
	#region Starting state
	structIter = new StructIter({});
	assert_equal(structIter.index, undefined, "Core with StructIter - Starting state - Bad index for empty");
	assert_equal(structIter.value, undefined, "Core with StructIter - Starting state - Bad value for empty");
	assert_equal(structIter.getIndex(), undefined, "Core with StructIter - Starting state - Bad getIndex() for empty");
	assert_equal(structIter.getValue(), undefined, "Core with StructIter - Starting state - Bad getValue() for empty");
	
	structIter = new StructIter({ foo: "bar" });
	assert_equal(structIter.index, "foo", "Core with StructIter - Starting state - Bad index for normal");
	assert_equal(structIter.value, "bar", "Core with StructIter - Starting state - Bad value for normal");
	assert_equal(structIter.getIndex(), "foo", "Core with StructIter - Starting state - Bad getIndex() for normal");
	assert_equal(structIter.getValue(), "bar", "Core with StructIter - Starting state - Bad getValue() for normal");
	#endregion
	
	#region Fetching
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	assert_equal(gmi_array_sorted(structIter.fetch()), [111, 222, 333], "Core with StructIter - Fetching - Bad fetch()");
	structIter = new StructIter({ a: 111, b: 222 });
	assert_equal(gmi_array_sorted(structIter.fetch(3)), [111, 222], "Core with StructIter - Fetching - Bad fetch(3) overflowing");
	
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	assert_equal(gmi_array_sorted(structIter.fetchIndices()), ["a", "b", "c"], "Core with StructIter - Fetching - Bad fetchIndices()");
	structIter = new StructIter({ a: 111, b: 222 });
	assert_equal(gmi_array_sorted(structIter.fetchIndices(3)), ["a", "b"], "Core with StructIter - Fetching - Bad fetchIndices(3) overflowing");
	
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	assert_equal(gmi_array_sorted_by_column(structIter.fetchValueIndexArray(), 0), [[111, "a"], [222, "b"], [333, "c"]], "Core with StructIter - Fetching - Bad fetchValueIndexArray()");
	structIter = new StructIter({ a: 111, b: 222 });
	assert_equal(gmi_array_sorted_by_column(structIter.fetchValueIndexArray(3), 0), [[111, "a"], [222, "b"]], "Core with StructIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	assert_equal(structIter.fetchValueIndexStruct(), { a: 111, b: 222, c: 333 }, "Core with StructIter - Fetching - Bad fetchValueIndexStruct()");
	structIter = new StructIter({ a: 111, b: 222 });
	assert_equal(structIter.fetchValueIndexStruct(3), { a: 111, b: 222 }, "Core with StructIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	structIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with StructIter - ForEach - Bad forEach(call)");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", undefined], [222, "b", undefined], [333, "c", undefined]], "Core with StructIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	structIter = new StructIter({ a: 111 });
	structIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with StructIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", undefined]], "Core with StructIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	structIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with StructIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(gmi_array_sorted_by_column(spy.calls, 0), [[111, "a", 4321], [222, "b", 4321], [333, "c", 4321]], "Core with StructIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var structIterResult;
	
	spy.reset();
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	structIterResult = structIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with StructIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(gmi_array_sorted_by_column(structIterResult, 0), [[111, "a", undefined], [222, "b", undefined], [333, "c", undefined]], "Core with StructIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	structIter = new StructIter({ a: 111 });
	structIterResult = structIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with StructIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(gmi_array_sorted_by_column(structIterResult, 0), [[111, "a", undefined]], "Core with StructIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	structIter = new StructIter({ a: 111, b: 222, c: 333 });
	structIterResult = structIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with StructIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(gmi_array_sorted_by_column(structIterResult, 0), [[111, "a", 4321], [222, "b", 4321], [333, "c", 4321]], "Core with StructIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
