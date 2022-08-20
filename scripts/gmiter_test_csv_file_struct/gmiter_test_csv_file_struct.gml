///@func gmiter_test_csv_file_struct()
function gmiter_test_csv_file_struct(){
	var spy = new GMIterForEachSpy();
	var fixtures = [
		working_directory + "GMIter_test/struct0.csv",
		working_directory + "GMIter_test/struct1.csv",
		working_directory + "GMIter_test/struct2.csv",
		working_directory + "GMIter_test/struct3.csv",
		working_directory + "GMIter_test/struct4.csv",
	];
	var csvFileStructIter;
	
	#region Starting state
	csvFileStructIter = new CsvFileStructIter(fixtures[0]);
	assert_equal(csvFileStructIter.index, undefined, "Core with CsvFileStructIter - Starting state - Bad index for empty");
	assert_equal(csvFileStructIter.value, undefined, "Core with CsvFileStructIter - Starting state - Bad value for empty");
	assert_equal(csvFileStructIter.getIndex(), undefined, "Core with CsvFileStructIter - Starting state - Bad getIndex() for empty");
	assert_equal(csvFileStructIter.getValue(), undefined, "Core with CsvFileStructIter - Starting state - Bad getValue() for empty");
	csvFileStructIter.close();
	
	csvFileStructIter = new CsvFileStructIter(fixtures[1]);
	assert_equal(csvFileStructIter.index, 0, "Core with CsvFileStructIter - Starting state - Bad index for normal");
	assert_equal(csvFileStructIter.value, {foo: "aaa", bar: "111"}, "Core with CsvFileStructIter - Starting state - Bad value for normal");
	assert_equal(csvFileStructIter.getIndex(), 0, "Core with CsvFileStructIter - Starting state - Bad getIndex() for normal");
	assert_equal(csvFileStructIter.getValue(), {foo: "aaa", bar: "111"}, "Core with CsvFileStructIter - Starting state - Bad getValue() for normal");
	csvFileStructIter.close();
	#endregion
	
	#region Fetching
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetch(), [{foo: "aaa", bar: "111"}, {foo: "bbb", bar: "222"}, {foo: "ccc", bar: "333"}], "Core with CsvFileStructIter - Fetching - Bad fetch()");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetch(2), [{foo: "aaa", bar: "111"}, {foo: "bbb", bar: "222"}], "Core with CsvFileStructIter - Fetching - Bad fetch(2)");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[2]);
	assert_equal(csvFileStructIter.fetch(3), [{foo: "aaa", bar: "111"}, {foo: "bbb", bar: "222"}], "Core with CsvFileStructIter - Fetching - Bad fetch(3) overflowing");
	csvFileStructIter.close();
	
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchIndices(), [0, 1, 2], "Core with CsvFileStructIter - Fetching - Bad fetchIndices()");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchIndices(2), [0, 1], "Core with CsvFileStructIter - Fetching - Bad fetchIndices(2)");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[2]);
	assert_equal(csvFileStructIter.fetchIndices(3), [0, 1], "Core with CsvFileStructIter - Fetching - Bad fetchIndices(3) overflowing");
	csvFileStructIter.close();
	
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchValueIndexArray(), [[{foo: "aaa", bar: "111"}, 0], [{foo: "bbb", bar: "222"}, 1], [{foo: "ccc", bar: "333"}, 2]], "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexArray()");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchValueIndexArray(2), [[{foo: "aaa", bar: "111"}, 0], [{foo: "bbb", bar: "222"}, 1]], "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexArray(2)");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[2]);
	assert_equal(csvFileStructIter.fetchValueIndexArray(3), [[{foo: "aaa", bar: "111"}, 0], [{foo: "bbb", bar: "222"}, 1]], "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	csvFileStructIter.close();
	
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchValueIndexStruct(), GMIterStruct("0", {foo: "aaa", bar: "111"}, "1", {foo: "bbb", bar: "222"}, "2", {foo: "ccc", bar: "333"}), "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexStruct()");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	assert_equal(csvFileStructIter.fetchValueIndexStruct(2), GMIterStruct("0", {foo: "aaa", bar: "111"}, "1", {foo: "bbb", bar: "222"}), "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexStruct(2)");
	csvFileStructIter.close();
	csvFileStructIter = new CsvFileStructIter(fixtures[2]);
	assert_equal(csvFileStructIter.fetchValueIndexStruct(3), GMIterStruct("0", {foo: "aaa", bar: "111"}, "1", {foo: "bbb", bar: "222"}), "Core with CsvFileStructIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	csvFileStructIter.close();
	#endregion
	
	#region ForEach
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	csvFileStructIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[{foo: "aaa", bar: "111"}, 0, undefined], [{foo: "bbb", bar: "222"}, 1, undefined], [{foo: "ccc", bar: "333"}, 2, undefined]], "Core with CsvFileStructIter - ForEach - Bad forEach(call)");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[4]);
	csvFileStructIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[{foo: "aaa", bar: "111"}, 0, undefined], [{foo: "bbb", bar: "222"}, 1, undefined], [{foo: "ccc", bar: "333"}, 2, undefined]], "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3)");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[1]);
	csvFileStructIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[{foo: "aaa", bar: "111"}, 0, undefined]], "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3) overflow");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	csvFileStructIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[{foo: "aaa", bar: "111"}, 0, 4321], [{foo: "bbb", bar: "222"}, 1, 4321], [{foo: "ccc", bar: "333"}, 2, 4321]], "Core with CsvFileStructIter - ForEach - Bad forEach(call, 3, 4321)");
	csvFileStructIter.close();
	#endregion
	
	#region FetchForEach
	var csvFileStructIterResult;
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	csvFileStructIterResult = csvFileStructIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(csvFileStructIterResult, [[{foo: "aaa", bar: "111"}, 0, undefined], [{foo: "bbb", bar: "222"}, 1, undefined], [{foo: "ccc", bar: "333"}, 2, undefined]], "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call)");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[4]);
	csvFileStructIterResult = csvFileStructIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(csvFileStructIterResult, [[{foo: "aaa", bar: "111"}, 0, undefined], [{foo: "bbb", bar: "222"}, 1, undefined], [{foo: "ccc", bar: "333"}, 2, undefined]], "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3)");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[1]);
	csvFileStructIterResult = csvFileStructIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(csvFileStructIterResult, [[{foo: "aaa", bar: "111"}, 0, undefined]], "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	csvFileStructIter.close();
	
	spy.reset();
	csvFileStructIter = new CsvFileStructIter(fixtures[3]);
	csvFileStructIterResult = csvFileStructIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(csvFileStructIterResult, [[{foo: "aaa", bar: "111"}, 0, 4321], [{foo: "bbb", bar: "222"}, 1, 4321], [{foo: "ccc", bar: "333"}, 2, 4321]], "Core with CsvFileStructIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	csvFileStructIter.close();
	#endregion
}
