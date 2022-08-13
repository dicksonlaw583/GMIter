///@func gmiter_test_drone()
function gmiter_test_drone(){
	var spy = new GMIterForEachSpy();
	var droneIter;
	
	#region Starting state
	droneIter = new DroneIter("foo");
	assert_equal(droneIter.index, 0, "Core with DroneIter - Starting state - Bad index");
	assert_equal(droneIter.value, "foo", "Core with DroneIter - Starting state - Bad value");
	assert_equal(droneIter.getIndex(), 0, "Core with DroneIter - Starting state - Bad getIndex()");
	assert_equal(droneIter.getValue(), "foo", "Core with DroneIter - Starting state - Bad getValue()");
	#endregion
	
	#region Fetching
	droneIter = new DroneIter(1, 3);
	assert_equal(droneIter.fetch(), [1, 1, 1], "Core with DroneIter - Fetching - Bad fetch()");
	droneIter = new DroneIter(1);
	assert_equal(droneIter.fetch(2), [1, 1], "Core with DroneIter - Fetching - Bad fetch(2)");
	droneIter = new DroneIter(1, 2);
	assert_equal(droneIter.fetch(3), [1, 1], "Core with DroneIter - Fetching - Bad fetch(3) overflowing");
	
	droneIter = new DroneIter(2, 3);
	assert_equal(droneIter.fetchIndices(), [0, 1, 2], "Core with DroneIter - Fetching - Bad fetchIndices()");
	droneIter = new DroneIter(2);
	assert_equal(droneIter.fetchIndices(2), [0, 1], "Core with DroneIter - Fetching - Bad fetchIndices(2)");
	droneIter = new DroneIter(2, 2);
	assert_equal(droneIter.fetchIndices(3), [0, 1], "Core with DroneIter - Fetching - Bad fetchIndices(3) overflowing");
	
	droneIter = new DroneIter(3, 3);
	assert_equal(droneIter.fetchValueIndexArray(), [[3, 0], [3, 1], [3, 2]], "Core with DroneIter - Fetching - Bad fetchValueIndexArray()");
	droneIter = new DroneIter(3);
	assert_equal(droneIter.fetchValueIndexArray(2), [[3, 0], [3, 1]], "Core with DroneIter - Fetching - Bad fetchValueIndexArray(2)");
	droneIter = new DroneIter(3, 2);
	assert_equal(droneIter.fetchValueIndexArray(3), [[3, 0], [3, 1]], "Core with DroneIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	
	droneIter = new DroneIter(4, 3);
	assert_equal(droneIter.fetchValueIndexStruct(), GMIterStruct("0", 4, "1", 4, "2", 4), "Core with DroneIter - Fetching - Bad fetchValueIndexStruct()");
	droneIter = new DroneIter(4);
	assert_equal(droneIter.fetchValueIndexStruct(2), GMIterStruct("0", 4, "1", 4), "Core with DroneIter - Fetching - Bad fetchValueIndexStruct(2)");
	droneIter = new DroneIter(4, 2);
	assert_equal(droneIter.fetchValueIndexStruct(3), GMIterStruct("0", 4, "1", 4), "Core with DroneIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	droneIter = new DroneIter(5, 3);
	droneIter.forEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DroneIter - ForEach - Bad forEach(call)");
	assert_equal(spy.calls, [[5, 0, undefined], [5, 1, undefined], [5, 2, undefined]], "Core with DroneIter - ForEach - Bad forEach(call)");
	
	spy.reset();
	droneIter = new DroneIter(5);
	droneIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DroneIter - ForEach - Bad forEach(call, 3)");
	assert_equal(spy.calls, [[5, 0, undefined], [5, 1, undefined], [5, 2, undefined]], "Core with DroneIter - ForEach - Bad forEach(call, 3)");
	
	spy.reset();
	droneIter = new DroneIter(5, 1);
	droneIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DroneIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equal(spy.calls, [[5, 0, undefined]], "Core with DroneIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	droneIter = new DroneIter(5);
	droneIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DroneIter - ForEach - Bad forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[5, 0, 4321], [5, 1, 4321], [5, 2, 4321]], "Core with DroneIter - ForEach - Bad forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var droneIterResult;
	
	spy.reset();
	droneIter = new DroneIter(6, 3);
	droneIterResult = droneIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 3, "Core with DroneIter - FetchForEach - Bad fetchForEach(call)");
	assert_equal(droneIterResult, [[6, 0, undefined], [6, 1, undefined], [6, 2, undefined]], "Core with DroneIter - FetchForEach - Bad fetchForEach(call)");
	
	spy.reset();
	droneIter = new DroneIter(6);
	droneIterResult = droneIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3)");
	assert_equal(droneIterResult, [[6, 0, undefined], [6, 1, undefined], [6, 2, undefined]], "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3)");
	
	spy.reset();
	droneIter = new DroneIter(6, 1);
	droneIterResult = droneIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 1, "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equal(droneIterResult, [[6, 0, undefined]], "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	droneIter = new DroneIter(6);
	droneIterResult = droneIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	assert_equal(droneIterResult, [[6, 0, 4321], [6, 1, 4321], [6, 2, 4321]], "Core with DroneIter - FetchForEach - Bad fetchForEach(call, 3, 4321)");
	#endregion
}
