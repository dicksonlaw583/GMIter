///@func gmiter_test_csv_file_array()
function gmiter_test_csv_file_array(){
	var spy = new GMIterForEachSpy();
	var fixtures = [
		working_directory + "GMIter_test/array0.csv",
		working_directory + "GMIter_test/array1.csv",
		working_directory + "GMIter_test/array2.csv",
		working_directory + "GMIter_test/array3.csv",
		working_directory + "GMIter_test/array4.csv",
	];
	var csvFileArrayIter;
	
	#region Starting state
	csvFileArrayIter = new CsvFileArrayIter(fixtures[0]);
	assert_equal(csvFileArrayIter.index, undefined, "Core with CsvFileArrayIter - Starting state - Bad index for empty");
	assert_equal(csvFileArrayIter.value, undefined, "Core with CsvFileArrayIter - Starting state - Bad value for empty");
	assert_equal(csvFileArrayIter.getIndex(), undefined, "Core with CsvFileArrayIter - Starting state - Bad getIndex() for empty");
	assert_equal(csvFileArrayIter.getValue(), undefined, "Core with CsvFileArrayIter - Starting state - Bad getValue() for empty");
	csvFileArrayIter.close();
	
	csvFileArrayIter = new CsvFileArrayIter(fixtures[1]);
	assert_equal(csvFileArrayIter.index, 0, "Core with CsvFileArrayIter - Starting state - Bad index for normal");
	assert_equal(csvFileArrayIter.value, ["aaa", "111"], "Core with CsvFileArrayIter - Starting state - Bad value for normal");
	assert_equal(csvFileArrayIter.getIndex(), 0, "Core with CsvFileArrayIter - Starting state - Bad getIndex() for normal");
	assert_equal(csvFileArrayIter.getValue(), ["aaa", "111"], "Core with CsvFileArrayIter - Starting state - Bad getValue() for normal");
	csvFileArrayIter.close();
	#endregion
	
	#region Fetching
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetch(), [["aaa", "111"], ["bbb", "222"], ["ccc", "333"]], "Core with CsvFileArrayIter - Fetching - Bad fetch()");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetch(2), [["aaa", "111"], ["bbb", "222"]], "Core with CsvFileArrayIter - Fetching - Bad fetch(2)");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[2]);
	assert_equal(csvFileArrayIter.fetch(3), [["aaa", "111"], ["bbb", "222"]], "Core with CsvFileArrayIter - Fetching - Bad fetch(3) overflowing");
	csvFileArrayIter.close();
	
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchIndices(), [0, 1, 2], "Core with CsvFileArrayIter - Fetching - Bad fetchIndices()");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchIndices(2), [0, 1], "Core with CsvFileArrayIter - Fetching - Bad fetchIndices(2)");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[2]);
	assert_equal(csvFileArrayIter.fetchIndices(3), [0, 1], "Core with CsvFileArrayIter - Fetching - Bad fetchIndices(3) overflowing");
	csvFileArrayIter.close();
	
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchValueIndexArray(), [[["aaa", "111"], 0], [["bbb", "222"], 1], [["ccc", "333"], 2]], "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexArray()");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchValueIndexArray(2), [[["aaa", "111"], 0], [["bbb", "222"], 1]], "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexArray(2)");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[2]);
	assert_equal(csvFileArrayIter.fetchValueIndexArray(3), [[["aaa", "111"], 0], [["bbb", "222"], 1]], "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	csvFileArrayIter.close();
	
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchValueIndexStruct(), GMIterStruct("0", ["aaa", "111"], "1", ["bbb", "222"], "2", ["ccc", "333"]), "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexStruct()");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	assert_equal(csvFileArrayIter.fetchValueIndexStruct(2), GMIterStruct("0", ["aaa", "111"], "1", ["bbb", "222"]), "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexStruct(2)");
	csvFileArrayIter.close();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[2]);
	assert_equal(csvFileArrayIter.fetchValueIndexStruct(3), GMIterStruct("0", ["aaa", "111"], "1", ["bbb", "222"]), "Core with CsvFileArrayIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	csvFileArrayIter.close();
	#endregion
	
	#region ForEach
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	csvFileArrayIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[["aaa", "111"], 0, undefined], [["bbb", "222"], 1, undefined], [["ccc", "333"], 2, undefined]], "Core with CsvFileArrayIter - ForEach - Bad forEach(call)");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[4]);
	csvFileArrayIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[["aaa", "111"], 0, undefined], [["bbb", "222"], 1, undefined], [["ccc", "333"], 2, undefined]], "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3)");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[1]);
	csvFileArrayIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[["aaa", "111"], 0, undefined]], "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3) overflow");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	csvFileArrayIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[["aaa", "111"], 0, 4321], [["bbb", "222"], 1, 4321], [["ccc", "333"], 2, 4321]], "Core with CsvFileArrayIter - ForEach - Bad forEach(call, 3, 4321)");
	csvFileArrayIter.close();
	#endregion
	
	#region FetchForEach
	var csvFileArrayIterResult;
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	csvFileArrayIterResult = csvFileArrayIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(csvFileArrayIterResult, [[["aaa", "111"], 0, undefined], [["bbb", "222"], 1, undefined], [["ccc", "333"], 2, undefined]], "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call)");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[4]);
	csvFileArrayIterResult = csvFileArrayIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(csvFileArrayIterResult, [[["aaa", "111"], 0, undefined], [["bbb", "222"], 1, undefined], [["ccc", "333"], 2, undefined]], "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3)");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[1]);
	csvFileArrayIterResult = csvFileArrayIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(csvFileArrayIterResult, [[["aaa", "111"], 0, undefined]], "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	csvFileArrayIter.close();
	
	spy.reset();
	csvFileArrayIter = new CsvFileArrayIter(fixtures[3]);
	csvFileArrayIterResult = csvFileArrayIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(csvFileArrayIterResult, [[["aaa", "111"], 0, 4321], [["bbb", "222"], 1, 4321], [["ccc", "333"], 2, 4321]], "Core with CsvFileArrayIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	csvFileArrayIter.close();
	#endregion
}
