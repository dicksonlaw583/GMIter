///@func gmiter_test_text_file()
function gmiter_test_text_file(){
	var spy = new GMIterForEachSpy();
	var fixtures = [
		working_directory + "GMIter_test/file0.txt",
		working_directory + "GMIter_test/file1.txt",
		working_directory + "GMIter_test/file2.txt",
		working_directory + "GMIter_test/file3.txt",
		working_directory + "GMIter_test/file4.txt",
	];
	var textFileIter;
	
	#region Starting state
	textFileIter = new TextFileIter(fixtures[0]);
	assert_equal(textFileIter.index, undefined, "Core with TextFileIter - Starting state - Bad index for empty");
	assert_equal(textFileIter.value, undefined, "Core with TextFileIter - Starting state - Bad value for empty");
	assert_equal(textFileIter.getIndex(), undefined, "Core with TextFileIter - Starting state - Bad getIndex() for empty");
	assert_equal(textFileIter.getValue(), undefined, "Core with TextFileIter - Starting state - Bad getValue() for empty");
	textFileIter.close();
	
	textFileIter = new TextFileIter(fixtures[1]);
	assert_equal(textFileIter.index, 0, "Core with TextFileIter - Starting state - Bad index for normal");
	assert_equal(textFileIter.value, "aaa", "Core with TextFileIter - Starting state - Bad value for normal");
	assert_equal(textFileIter.getIndex(), 0, "Core with TextFileIter - Starting state - Bad getIndex() for normal");
	assert_equal(textFileIter.getValue(), "aaa", "Core with TextFileIter - Starting state - Bad getValue() for normal");
	textFileIter.close();
	#endregion
	
	#region Fetching
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetch(), ["aaa", "bbb", "ccc"], "Core with TextFileIter - Fetching - Bad fetch()");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetch(2), ["aaa", "bbb"], "Core with TextFileIter - Fetching - Bad fetch(2)");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[2]);
	assert_equal(textFileIter.fetch(3), ["aaa", "bbb"], "Core with TextFileIter - Fetching - Bad fetch(3) overflowing");
	textFileIter.close();
	
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchIndices(), [0, 1, 2], "Core with TextFileIter - Fetching - Bad fetchIndices()");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchIndices(2), [0, 1], "Core with TextFileIter - Fetching - Bad fetchIndices(2)");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[2]);
	assert_equal(textFileIter.fetchIndices(3), [0, 1], "Core with TextFileIter - Fetching - Bad fetchIndices(3) overflowing");
	textFileIter.close();
	
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchValueIndexArray(), [["aaa", 0], ["bbb", 1], ["ccc", 2]], "Core with TextFileIter - Fetching - Bad fetchValueIndexArray()");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchValueIndexArray(2), [["aaa", 0], ["bbb", 1]], "Core with TextFileIter - Fetching - Bad fetchValueIndexArray(2)");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[2]);
	assert_equal(textFileIter.fetchValueIndexArray(3), [["aaa", 0], ["bbb", 1]], "Core with TextFileIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	textFileIter.close();
	
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchValueIndexStruct(), GMIterStruct("0", "aaa", "1", "bbb", "2", "ccc"), "Core with TextFileIter - Fetching - Bad fetchValueIndexStruct()");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[3]);
	assert_equal(textFileIter.fetchValueIndexStruct(2), GMIterStruct("0", "aaa", "1", "bbb"), "Core with TextFileIter - Fetching - Bad fetchValueIndexStruct(2)");
	textFileIter.close();
	textFileIter = new TextFileIter(fixtures[2]);
	assert_equal(textFileIter.fetchValueIndexStruct(3), GMIterStruct("0", "aaa", "1", "bbb"), "Core with TextFileIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	textFileIter.close();
	#endregion
	
	#region ForEach
	spy.reset();
	textFileIter = new TextFileIter(fixtures[3]);
	textFileIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with TextFileIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [["aaa", 0, undefined], ["bbb", 1, undefined], ["ccc", 2, undefined]], "Core with TextFileIter - ForEach - Bad forEach(call)");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[4]);
	textFileIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with TextFileIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [["aaa", 0, undefined], ["bbb", 1, undefined], ["ccc", 2, undefined]], "Core with TextFileIter - ForEach - Bad forEach(call, 3)");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[1]);
	textFileIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with TextFileIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [["aaa", 0, undefined]], "Core with TextFileIter - ForEach - Bad forEach(call, 3) overflow");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[3]);
	textFileIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with TextFileIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [["aaa", 0, 4321], ["bbb", 1, 4321], ["ccc", 2, 4321]], "Core with TextFileIter - ForEach - Bad forEach(call, 3, 4321)");
	textFileIter.close();
	#endregion
	
	#region FetchForEach
	var textFileIterResult;
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[3]);
	textFileIterResult = textFileIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with TextFileIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(textFileIterResult, [["aaa", 0, undefined], ["bbb", 1, undefined], ["ccc", 2, undefined]], "Core with TextFileIter - FetchForEach - Bad fetchForEach(call)");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[4]);
	textFileIterResult = textFileIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(textFileIterResult, [["aaa", 0, undefined], ["bbb", 1, undefined], ["ccc", 2, undefined]], "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3)");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[1]);
	textFileIterResult = textFileIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(textFileIterResult, [["aaa", 0, undefined]], "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	textFileIter.close();
	
	spy.reset();
	textFileIter = new TextFileIter(fixtures[3]);
	textFileIterResult = textFileIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(textFileIterResult, [["aaa", 0, 4321], ["bbb", 1, 4321], ["ccc", 2, 4321]], "Core with TextFileIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	textFileIter.close();
	#endregion
}
