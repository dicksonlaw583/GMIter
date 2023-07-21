///@func gmiter_test_circle()
function gmiter_test_circle(){
	var spy = new GMIterForEachSpy();
	/*
	All tests here use a centred at (333, 222) with radius 111.
	
	These are the 4 references points, CCW from due right.
	*/
	var points = [
		[444, 222],
		[333, 111],
		[222, 222],
		[333, 333],
	];
	var iter;

	#region Starting state
	iter = new CircleIter(333, 222, 111, 0);
	assert_equalish(iter.index, [0, 0], "Core with CircleIter - Starting state - Bad index for empty");
	assert_equalish(iter.value, points[0], "Core with CircleIter - Starting state - Bad value for empty");
	assert_equalish(iter.getIndex(), [0, 0], "Core with CircleIter - Starting state - Bad getIndex() for empty");
	assert_equalish(iter.getValue(), points[0], "Core with CircleIter - Starting state - Bad getValue() for empty");
	
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.index, [0, 0], "Core with CircleIter - Starting state - index for normal");
	assert_equalish(iter.value, points[0], "Core with CircleIter - Starting state - value for normal");
	assert_equalish(iter.getIndex(), [0, 0], "Core with CircleIter - Starting state - getIndex() for normal");
	assert_equalish(iter.getValue(), points[0], "Core with CircleIter - Starting state - getValue() for normal");
	#endregion

	#region Fetching
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetch(), points, "Core with CircleIter - Fetching - fetch()");
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetch(2), [points[0], points[1]], "Core with CircleIter - Fetching - fetch(2)");
	iter = new CircleIter(333, 222, 111, 2);
	assert_equalish(iter.fetch(3), [points[0], points[2]], "Core with CircleIter - Fetching - Bad fetch(3) overflowing");
	iter = new CircleIter(333, 222, 111, 4, 90);
	assert_equalish(iter.fetch(), [points[1], points[2], points[3], points[0]], "Core with CircleIter offset - Fetching - fetch()");
	iter = new CircleIter(333, 222, 111, 4, 90);
	assert_equalish(iter.fetch(2), [points[1], points[2]], "Core with CircleIter offset - Fetching - fetch(2)");
	iter = new CircleIter(333, 222, 111, 2, 90);
	assert_equalish(iter.fetch(3), [points[1], points[3]], "Core with CircleIter offset - Fetching - Bad fetch(3) overflowing");
	iter = new CircleIter(333, 222, 111, 4, 90, -270);
	assert_equalish(iter.fetch(), [points[1], points[0], points[3], points[2]], "Core with CircleIter offset CCW - Fetching - fetch()");
	iter = new CircleIter(333, 222, 111, 4, 90, -270);
	assert_equalish(iter.fetch(2), [points[1], points[0]], "Core with CircleIter offset CCW - Fetching - fetch(2)");
	iter = new CircleIter(333, 222, 111, 2, 90, -270);
	assert_equalish(iter.fetch(3), [points[1], points[3]], "Core with CircleIter offset CCW - Fetching - Bad fetch(3) overflowing");
	iter = new CircleIter(333, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(), [points[1], points[3], points[1]], "Core with CircleIter inclusive - Fetching - fetch()");
	iter = new CircleIter(333, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(2), [points[1], points[3]], "Core with CircleIter inclusive - Fetching - fetch(2)");
	iter = new CircleIter(333, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(4), [points[1], points[3], points[1]], "Core with CircleIter inclusive - Fetching - fetch(4) overflowing");
	
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchIndices(), [[0, 0], [1, 1/3], [2, 2/3], [3, 1]], "Core with CircleIter - Fetching - fetchIndices()");
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchIndices(2), [[0, 0], [1, 1/3]], "Core with CircleIter - Fetching - fetchIndices(2)");
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchIndices(5), [[0, 0], [1, 1/3], [2, 2/3], [3, 1]], "Core with CircleIter - Fetching - Bad fetchIndices(5) overflowing");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(), [[0, 0], [1, 1/2], [2, 1]], "Core with CircleIter inclusive - Fetching - fetchIndices()");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(2), [[0, 0], [1, 1/2]], "Core with CircleIter inclusive - Fetching - fetchIndices(2)");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(5), [[0, 0], [1, 1/2], [2, 1]], "Core with CircleIter inclusive - Fetching - Bad fetchIndices(5) overflowing");
	
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexArray(), [[points[0], [0, 0]], [points[1], [1, 1/3]], [points[2], [2, 2/3]], [points[3], [3, 1]]], "Core with CircleIter - Fetching - fetchValueIndexArray()");
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexArray(2), [[points[0], [0, 0]], [points[1], [1, 1/3]]], "Core with CircleIter - Fetching - fetchValueIndexArray(2)");
	iter = new CircleIter(333, 222, 111, 2);
	assert_equalish(iter.fetchValueIndexArray(3), [[points[0], [0, 0]], [points[2], [1, 1]]], "Core with CircleIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(), [[points[0], [0, 0]], [points[2], [1, 1/2]], [points[0], [2, 1]]], "Core with CircleIter inclusive - Fetching - fetchValueIndexArray()");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(2), [[points[0], [0, 0]], [points[2], [1, 1/2]]], "Core with CircleIter inclusive - Fetching - fetchValueIndexArray(2)");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(5), [[points[0], [0, 0]], [points[2], [1, 1/2]], [points[0], [2, 1]]], "Core with CircleIter inclusive - Fetching - Bad fetchValueIndexArray(5) overflowing");
	
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], points[0], [1, 1/3], points[1], [2, 2/3], points[2], [3, 1], points[3]), "Core with CircleIter - Fetching - fetchValueIndexStruct()");
	iter = new CircleIter(333, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], points[0], [1, 1/3], points[1]), "Core with CircleIter - Fetching - fetchValueIndexStruct(2)");
	iter = new CircleIter(333, 222, 111, 2);
	assert_equalish(iter.fetchValueIndexStruct(3), GMIterStruct([0, 0], points[0], [1, 1], points[2]), "Core with CircleIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], points[0], [1, 1/2], points[2], [2, 1], points[0]), "Core with CircleIter - Fetching - fetchValueIndexStruct()");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], points[0], [1, 1/2], points[2]), "Core with CircleIter - Fetching - fetchValueIndexStruct(2)");
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(5), GMIterStruct([0, 0], points[0], [1, 1/2], points[2], [2, 1], points[0]), "Core with CircleIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	iter.forEach(spy.call);
	assert_equalish(spy.count(), 4, "Core with CircleIter - ForEach - forEach(call)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined], [points[3], [3, 1], undefined]], "Core with CircleIter - ForEach - forEach(call)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 3, "Core with CircleIter - ForEach - forEach(call, 3)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined]], "Core with CircleIter - ForEach - forEach(call, 3)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 1);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with CircleIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined]], "Core with CircleIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	iter.forEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with CircleIter - ForEach - forEach(call, 3, 4321)");
	assert_equalish(spy.calls, [[points[0], [0, 0], 4321], [points[1], [1, 1/3], 4321], [points[2], [2, 2/3], 4321]], "Core with CircleIter - ForEach - forEach(call, 3, 4321)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call);
	assert_equalish(spy.count(), 3, "Core with CircleIter inclusive - ForEach - forEach(call)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined], [points[0], [2, 1], undefined]], "Core with CircleIter inclusive - ForEach - forEach(call)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call, 2);
	assert_equalish(spy.count(), 2, "Core with CircleIter inclusive - ForEach - forEach(call, 2)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined]], "Core with CircleIter inclusive - ForEach - forEach(call, 2)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 1, 0, 360, true);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with CircleIter inclusive - ForEach - Bad forEach(call, 3) overflow");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined]], "Core with CircleIter inclusive - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call, 2, 4321);
	assert_equalish(spy.count(), 2, "Core with CircleIter inclusive - ForEach - forEach(call, 2, 4321)");
	assert_equalish(spy.calls, [[points[0], [0, 0], 4321], [points[2], [1, 1/2], 4321]], "Core with CircleIter inclusive - ForEach - forEach(call, 2, 4321)");
	#endregion
	
	#region FetchForEach
	var CircleIterResult;
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	CircleIterResult = iter.fetchForEach(spy.call);
	assert_equalish(spy.count(), 4, "Core with CircleIter - FetchForEach - fetchForEach(call)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined], [points[3], [3, 1], undefined]], "Core with CircleIter - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	CircleIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 3, "Core with CircleIter - FetchForEach - fetchForEach(call, 3)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined]], "Core with CircleIter - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 1);
	CircleIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with CircleIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined]], "Core with CircleIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 4);
	CircleIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with CircleIter - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], 4321], [points[1], [1, 1/3], 4321], [points[2], [2, 2/3], 4321]], "Core with CircleIter - FetchForEach - fetchForEach(call, 3, 4321)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	CircleIterResult = iter.fetchForEach(spy.call);
	assert_equalish(spy.count(), 3, "Core with CircleIter inclusive - FetchForEach - fetchForEach(call)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined], [points[0], [2, 1], undefined]], "Core with CircleIter inclusive - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	CircleIterResult = iter.fetchForEach(spy.call, 2);
	assert_equalish(spy.count(), 2, "Core with CircleIter inclusive - FetchForEach - fetchForEach(call, 3)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined]], "Core with CircleIter inclusive - FetchForEach - fetchForEach(call, 2)");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 1, 0, 360, true);
	CircleIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with CircleIter inclusive - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], undefined]], "Core with CircleIter inclusive - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new CircleIter(333, 222, 111, 3, 0, 360, true);
	CircleIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with CircleIter inclusive - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equalish(CircleIterResult, [[points[0], [0, 0], 4321], [points[2], [1, 1/2], 4321], [points[0], [2, 1], 4321]], "Core with CircleIter inclusive - FetchForEach - fetchForEach(call, 3, 4321)");
	#endregion
}
