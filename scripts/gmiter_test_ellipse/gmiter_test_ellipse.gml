///@func gmiter_test_ellipse()
function gmiter_test_ellipse(){
	var spy = new GMIterForEachSpy();
	/*
	All tests here use an ellipse centred at (333, 222),
	with X radius 222 and Y radius 111.
	
	These are the 4 references points, CCW from due right.
	*/
	var points = [
		[555, 222],
		[333, 111],
		[111, 222],
		[333, 333],
	];
	var iter;

	#region Starting state
	iter = new EllipseIter(333, 222, 222, 111, 0);
	assert_equalish(iter.index, [0, 0], "Core with EllipseIter - Starting state - Bad index for empty");
	assert_equalish(iter.value, points[0], "Core with EllipseIter - Starting state - Bad value for empty");
	assert_equalish(iter.getIndex(), [0, 0], "Core with EllipseIter - Starting state - Bad getIndex() for empty");
	assert_equalish(iter.getValue(), points[0], "Core with EllipseIter - Starting state - Bad getValue() for empty");
	
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.index, [0, 0], "Core with EllipseIter - Starting state - index for normal");
	assert_equalish(iter.value, points[0], "Core with EllipseIter - Starting state - value for normal");
	assert_equalish(iter.getIndex(), [0, 0], "Core with EllipseIter - Starting state - getIndex() for normal");
	assert_equalish(iter.getValue(), points[0], "Core with EllipseIter - Starting state - getValue() for normal");
	#endregion

	#region Fetching
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetch(), points, "Core with EllipseIter - Fetching - fetch()");
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetch(2), [points[0], points[1]], "Core with EllipseIter - Fetching - fetch(2)");
	iter = new EllipseIter(333, 222, 222, 111, 2);
	assert_equalish(iter.fetch(3), [points[0], points[2]], "Core with EllipseIter - Fetching - Bad fetch(3) overflowing");
	iter = new EllipseIter(333, 222, 222, 111, 4, 90);
	assert_equalish(iter.fetch(), [points[1], points[2], points[3], points[0]], "Core with EllipseIter offset - Fetching - Bad fetch()");
	iter = new EllipseIter(333, 222, 222, 111, 4, 90);
	assert_equalish(iter.fetch(2), [points[1], points[2]], "Core with EllipseIter offset - Fetching - fetch(2)");
	iter = new EllipseIter(333, 222, 222, 111, 2, 90);
	assert_equalish(iter.fetch(3), [points[1], points[3]], "Core with EllipseIter offset - Fetching - Bad fetch(3) overflowing");
	iter = new EllipseIter(333, 222, 222, 111, 4, 90, -270);
	assert_equalish(iter.fetch(), [points[1], points[0], points[3], points[2]], "Core with EllipseIter offset CCW - Fetching - fetch()");
	iter = new EllipseIter(333, 222, 222, 111, 4, 90, -270);
	assert_equalish(iter.fetch(2), [points[1], points[0]], "Core with EllipseIter offset CCW - Fetching - fetch(2)");
	iter = new EllipseIter(333, 222, 222, 111, 2, 90, -270);
	assert_equalish(iter.fetch(3), [points[1], points[3]], "Core with EllipseIter offset CCW - Fetching - Bad fetch(3) overflowing");
	iter = new EllipseIter(333, 222, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(), [points[1], points[3], points[1]], "Core with EllipseIter inclusive - Fetching - fetch()");
	iter = new EllipseIter(333, 222, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(2), [points[1], points[3]], "Core with EllipseIter inclusive - Fetching - fetch(2)");
	iter = new EllipseIter(333, 222, 222, 111, 3, 90, 450, true);
	assert_equalish(iter.fetch(4), [points[1], points[3], points[1]], "Core with EllipseIter inclusive - Fetching - Bad fetch(4) overflowing");
	
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchIndices(), [[0, 0], [1, 1/3], [2, 2/3], [3, 1]], "Core with EllipseIter - Fetching - fetchIndices()");
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchIndices(2), [[0, 0], [1, 1/3]], "Core with EllipseIter - Fetching - fetchIndices(2)");
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchIndices(5), [[0, 0], [1, 1/3], [2, 2/3], [3, 1]], "Core with EllipseIter - Fetching - Bad fetchIndices(5) overflowing");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(), [[0, 0], [1, 1/2], [2, 1]], "Core with EllipseIter inclusive - Fetching - fetchIndices()");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(2), [[0, 0], [1, 1/2]], "Core with EllipseIter inclusive - Fetching - fetchIndices(2)");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchIndices(5), [[0, 0], [1, 1/2], [2, 1]], "Core with EllipseIter inclusive - Fetching - Bad fetchIndices(5) overflowing");
	
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexArray(), [[points[0], [0, 0]], [points[1], [1, 1/3]], [points[2], [2, 2/3]], [points[3], [3, 1]]], "Core with EllipseIter - Fetching - fetchValueIndexArray()");
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexArray(2), [[points[0], [0, 0]], [points[1], [1, 1/3]]], "Core with EllipseIter - Fetching - fetchValueIndexArray(2)");
	iter = new EllipseIter(333, 222, 222, 111, 2);
	assert_equalish(iter.fetchValueIndexArray(3), [[points[0], [0, 0]], [points[2], [1, 1]]], "Core with EllipseIter - Fetching - Bad fetchValueIndexArray(3) overflowing");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(), [[points[0], [0, 0]], [points[2], [1, 1/2]], [points[0], [2, 1]]], "Core with EllipseIter inclusive - Fetching - fetchValueIndexArray()");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(2), [[points[0], [0, 0]], [points[2], [1, 1/2]]], "Core with EllipseIter inclusive - Fetching - fetchValueIndexArray(2)");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexArray(5), [[points[0], [0, 0]], [points[2], [1, 1/2]], [points[0], [2, 1]]], "Core with EllipseIter inclusive - Fetching - Bad fetchValueIndexArray(5) overflowing");
	
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], points[0], [1, 1/3], points[1], [2, 2/3], points[2], [3, 1], points[3]), "Core with EllipseIter - Fetching - fetchValueIndexStruct()");
	iter = new EllipseIter(333, 222, 222, 111, 4);
	assert_equalish(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], points[0], [1, 1/3], points[1]), "Core with EllipseIter - Fetching - fetchValueIndexStruct(2)");
	iter = new EllipseIter(333, 222, 222, 111, 2);
	assert_equalish(iter.fetchValueIndexStruct(3), GMIterStruct([0, 0], points[0], [1, 1], points[2]), "Core with EllipseIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(), GMIterStruct([0, 0], points[0], [1, 1/2], points[2], [2, 1], points[0]), "Core with EllipseIter - Fetching - fetchValueIndexStruct()");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(2), GMIterStruct([0, 0], points[0], [1, 1/2], points[2]), "Core with EllipseIter - Fetching - fetchValueIndexStruct(2)");
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	assert_equalish(iter.fetchValueIndexStruct(5), GMIterStruct([0, 0], points[0], [1, 1/2], points[2], [2, 1], points[0]), "Core with EllipseIter - Fetching - Bad fetchValueIndexStruct(3) overflow");
	#endregion
	
	#region ForEach
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	iter.forEach(spy.call);
	assert_equalish(spy.count(), 4, "Core with EllipseIter - ForEach - forEach(call)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined], [points[3], [3, 1], undefined]], "Core with EllipseIter - ForEach - forEach(call)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 3, "Core with EllipseIter - ForEach - forEach(call, 3)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined]], "Core with EllipseIter - ForEach - forEach(call, 3)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 1);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with EllipseIter - ForEach - Bad forEach(call, 3) overflow");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined]], "Core with EllipseIter - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	iter.forEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with EllipseIter - ForEach - forEach(call, 3, 4321)");
	assert_equalish(spy.calls, [[points[0], [0, 0], 4321], [points[1], [1, 1/3], 4321], [points[2], [2, 2/3], 4321]], "Core with EllipseIter - ForEach - forEach(call, 3, 4321)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call);
	assert_equalish(spy.count(), 3, "Core with EllipseIter inclusive - ForEach - forEach(call)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined], [points[0], [2, 1], undefined]], "Core with EllipseIter inclusive - ForEach - forEach(call)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call, 2);
	assert_equalish(spy.count(), 2, "Core with EllipseIter inclusive - ForEach - forEach(call, 2)");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined]], "Core with EllipseIter inclusive - ForEach - forEach(call, 2)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 1, 0, 360, true);
	iter.forEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with EllipseIter inclusive - ForEach - Bad forEach(call, 3) overflow");
	assert_equalish(spy.calls, [[points[0], [0, 0], undefined]], "Core with EllipseIter inclusive - ForEach - Bad forEach(call, 3) overflow");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	iter.forEach(spy.call, 2, 4321);
	assert_equalish(spy.count(), 2, "Core with EllipseIter inclusive - ForEach - forEach(call, 2, 4321)");
	assert_equalish(spy.calls, [[points[0], [0, 0], 4321], [points[2], [1, 1/2], 4321]], "Core with EllipseIter inclusive - ForEach - forEach(call, 2, 4321)");
	#endregion
	
	#region FetchForEach
	var EllipseIterResult;
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	EllipseIterResult = iter.fetchForEach(spy.call);
	assert_equalish(spy.count(), 4, "Core with EllipseIter - FetchForEach - fetchForEach(call)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined], [points[3], [3, 1], undefined]], "Core with EllipseIter - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	EllipseIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 3, "Core with EllipseIter - FetchForEach - fetchForEach(call, 3)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined], [points[1], [1, 1/3], undefined], [points[2], [2, 2/3], undefined]], "Core with EllipseIter - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 1);
	EllipseIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with EllipseIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined]], "Core with EllipseIter - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 4);
	EllipseIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with EllipseIter - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], 4321], [points[1], [1, 1/3], 4321], [points[2], [2, 2/3], 4321]], "Core with EllipseIter - FetchForEach - fetchForEach(call, 3, 4321)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	EllipseIterResult = iter.fetchForEach(spy.call);
	assert_equalish(spy.count(), 3, "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined], [points[0], [2, 1], undefined]], "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	EllipseIterResult = iter.fetchForEach(spy.call, 2);
	assert_equalish(spy.count(), 2, "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call, 3)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined], [points[2], [1, 1/2], undefined]], "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call, 2)");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 1, 0, 360, true);
	EllipseIterResult = iter.fetchForEach(spy.call, 3);
	assert_equalish(spy.count(), 1, "Core with EllipseIter inclusive - FetchForEach - Bad fetchForEach(call, 3) overflow");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], undefined]], "Core with EllipseIter inclusive - FetchForEach - Bad fetchForEach(call, 3) overflow");
	
	spy.reset();
	iter = new EllipseIter(333, 222, 222, 111, 3, 0, 360, true);
	EllipseIterResult = iter.fetchForEach(spy.call, 3, 4321);
	assert_equalish(spy.count(), 3, "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equalish(EllipseIterResult, [[points[0], [0, 0], 4321], [points[2], [1, 1/2], 4321], [points[0], [2, 1], 4321]], "Core with EllipseIter inclusive - FetchForEach - fetchForEach(call, 3, 4321)");
	#endregion
}
