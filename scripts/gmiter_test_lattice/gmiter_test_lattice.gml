///@func gmiter_test_lattice()
function gmiter_test_lattice(){
	var spy = new GMIterForEachSpy();
	var latticeIter;
	
	/*
	Lattice points from (50, 60) through (250, 130), cell size 100x70.
	*/
	var p = [
		[50, 60],
		[150, 60],
		[250, 60],
		[50, 130],
		[150, 130],
		[250, 130],
	];
	
	#region Starting state
	latticeIter = new LatticeIter(0, 0, 0, 0, 0, 0);
	assert_equal(latticeIter.index, [0, 0], "Core with LatticeIter - Starting state - Bad index for empty");
	assert_equal(latticeIter.value, undefined, "Core with LatticeIter - Starting state - Bad value for empty");
	assert_equal(latticeIter.getIndex(), [0, 0], "Core with LatticeIter - Starting state - Bad getIndex() for empty");
	assert_equal(latticeIter.getValue(), undefined, "Core with LatticeIter - Starting state - Bad getValue() for empty");
	
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.index, [0, 0], "Core with LatticeIter - Starting state - index for normal");
	assert_equal(latticeIter.value, p[0], "Core with LatticeIter - Starting state - value for normal");
	assert_equal(latticeIter.getIndex(), [0, 0], "Core with LatticeIter - Starting state - getIndex() for normal");
	assert_equal(latticeIter.getValue(), p[0], "Core with LatticeIter - Starting state - getValue() for normal");
	#endregion
	
	#region Fetching
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetch(), [p[0], p[1], p[2], p[3], p[4], p[5]], "Core with LatticeIter - Fetching - fetch()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetch(2), [p[0], p[1]], "Core with LatticeIter - Fetching - fetch(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	assert_equal(latticeIter.fetch(5), [p[0], p[1], p[3], p[4]], "Core with LatticeIter - Fetching - Bad fetch(5) overflowing");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetch(), [p[0], p[3], p[1], p[4], p[2], p[5]], "Core with LatticeIter column - Fetching - fetch()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetch(2), [p[0], p[3]], "Core with LatticeIter column - Fetching - fetch(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	assert_equal(latticeIter.fetch(5), [p[0], p[3], p[1], p[4]], "Core with LatticeIter column - Fetching - Bad fetch() overflowing");
	
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchIndices(), [[0, 0], [1, 0], [2, 0], [0, 1], [1, 1], [2, 1]], "Core with LatticeIter - Fetching - fetchIndices()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchIndices(2), [[0, 0], [1, 0]], "Core with LatticeIter - Fetching - fetchIndices(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	assert_equal(latticeIter.fetchIndices(5), [[0, 0], [1, 0], [0, 1], [1, 1]], "Core with LatticeIter - Fetching - Bad fetchIndices(5) overflowing");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchIndices(), [[0, 0], [0, 1], [1, 0], [1, 1], [2, 0], [2, 1]], "Core with LatticeIter column - Fetching - fetchIndices()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchIndices(2), [[0, 0], [0, 1]], "Core with LatticeIter column - Fetching - fetchIndices(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	assert_equal(latticeIter.fetchIndices(5), [[0, 0], [0, 1], [1, 0], [1, 1]], "Core with LatticeIter column - Fetching - Bad fetchIndices(5) overflowing");
	
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchValueIndexArray(), [[p[0], [0, 0]], [p[1], [1, 0]], [p[2], [2, 0]], [p[3], [0, 1]], [p[4], [1, 1]], [p[5], [2, 1]]], "Core with LatticeIter - Fetching - fetchValueIndexArray()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchValueIndexArray(2), [[p[0], [0, 0]], [p[1], [1, 0]]], "Core with LatticeIter - Fetching - fetchValueIndexArray(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	assert_equal(latticeIter.fetchValueIndexArray(5), [[p[0], [0, 0]], [p[1], [1, 0]], [p[3], [0, 1]], [p[4], [1, 1]]], "Core with LatticeIter - Fetching - Bad fetchValueIndexArray(5) overflowing");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchValueIndexArray(), [[p[0], [0, 0]], [p[3], [0, 1]], [p[1], [1, 0]], [p[4], [1, 1]], [p[2], [2, 0]], [p[5], [2, 1]]], "Core with LatticeIter column - Fetching - fetchValueIndexArray()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchValueIndexArray(2), [[p[0], [0, 0]], [p[3], [0, 1]]], "Core with LatticeIter column - Fetching - fetchValueIndexArray(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	assert_equal(latticeIter.fetchValueIndexArray(5), [[p[0], [0, 0]], [p[3], [0, 1]], [p[1], [1, 0]], [p[4], [1, 1]]], "Core with LatticeIter column - Fetching - Bad fetchValueIndexArray(5) overflowing");
	
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchValueIndexStruct(), GMIterStruct([0, 0], p[0], [1, 0], p[1], [2, 0], p[2], [0, 1], p[3], [1, 1], p[4], [2, 1], p[5]), "Core with LatticeIter - Fetching - fetchValueIndexStruct()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	assert_equal(latticeIter.fetchValueIndexStruct(2), GMIterStruct([0, 0], p[0], [1, 0], p[1]), "Core with LatticeIter - Fetching - fetchValueIndexStruct(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	assert_equal(latticeIter.fetchValueIndexStruct(5), GMIterStruct([0, 0], p[0], [1, 0], p[1], [0, 1], p[3], [1, 1], p[4]), "Core with LatticeIter - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchValueIndexStruct(), GMIterStruct([0, 0], p[0], [0, 1], p[3], [1, 0], p[1], [1, 1], p[4], [2, 0], p[2], [2, 1], p[5]), "Core with LatticeIter column - Fetching - fetchValueIndexStruct()");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	assert_equal(latticeIter.fetchValueIndexStruct(2), GMIterStruct([0, 0], p[0], [0, 1], p[3]), "Core with LatticeIter column - Fetching - fetchValueIndexStruct(2)");
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	assert_equal(latticeIter.fetchValueIndexStruct(5), GMIterStruct([0, 0], p[0], [0, 1], p[3], [1, 0], p[1], [1, 1], p[4]), "Core with LatticeIter column - Fetching - Bad fetchValueIndexStruct(5) overflowing");
	#endregion
	
	#region ForEach
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with LatticeIter - ForEach - forEach(call)");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[2], [2, 0], undefined], [p[3], [0, 1], undefined], [p[4], [1, 1], undefined], [p[5], [2, 1], undefined]], "Core with LatticeIter - ForEach - forEach(call)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LatticeIter - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[2], [2, 0], undefined]], "Core with LatticeIter - ForEach - forEach(call, 3)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	latticeIter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with LatticeIter - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[3], [0, 1], undefined], [p[4], [1, 1], undefined]], "Core with LatticeIter - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LatticeIter - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[p[0], [0, 0], 4321], [p[1], [1, 0], 4321], [p[2], [2, 0], 4321]], "Core with LatticeIter - ForEach - forEach(call, 3, 4321)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIter.forEach(spy.call);
	assert_equal(spy.count(), 6, "Core with LatticeIter column - ForEach - forEach(call)");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined], [p[4], [1, 1], undefined], [p[2], [2, 0], undefined], [p[5], [2, 1], undefined]], "Core with LatticeIter column - ForEach - forEach(call)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIter.forEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LatticeIter column - ForEach - forEach(call, 3)");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined]], "Core with LatticeIter column - ForEach - forEach(call, 3)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	latticeIter.forEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with LatticeIter column - ForEach - Bad forEach(call, 5) overflow");
	assert_equal(spy.calls, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined], [p[4], [1, 1], undefined]], "Core with LatticeIter column - ForEach - Bad forEach(call, 5) overflow");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIter.forEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LatticeIter column - ForEach - forEach(call, 3, 4321)");
	assert_equal(spy.calls, [[p[0], [0, 0], 4321], [p[3], [0, 1], 4321], [p[1], [1, 0], 4321]], "Core with LatticeIter column - ForEach - forEach(call, 3, 4321)");
	#endregion
	
	#region FetchForEach
	var latticeIterResult;
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIterResult = latticeIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with LatticeIter - FetchForEach - fetchForEach(call)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[2], [2, 0], undefined], [p[3], [0, 1], undefined], [p[4], [1, 1], undefined], [p[5], [2, 1], undefined]], "Core with LatticeIter - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LatticeIter - FetchForEach - fetchForEach(call, 3)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[2], [2, 0], undefined]], "Core with LatticeIter - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with LatticeIter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[1], [1, 0], undefined], [p[3], [0, 1], undefined], [p[4], [1, 1], undefined]], "Core with LatticeIter - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LatticeIter - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], 4321], [p[1], [1, 0], 4321], [p[2], [2, 0], 4321]], "Core with LatticeIter - FetchForEach - fetchForEach(call, 3, 4321)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIterResult = latticeIter.fetchForEach(spy.call);
	assert_equal(spy.count(), 6, "Core with LatticeIter column - FetchForEach - fetchForEach(call)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined], [p[4], [1, 1], undefined], [p[2], [2, 0], undefined], [p[5], [2, 1], undefined]], "Core with LatticeIter column - FetchForEach - fetchForEach(call)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 3);
	assert_equal(spy.count(), 3, "Core with LatticeIter column - FetchForEach - fetchForEach(call, 3)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined]], "Core with LatticeIter column - FetchForEach - fetchForEach(call, 3)");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[4][0], p[4][1], 2, 2, true);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 5);
	assert_equal(spy.count(), 4, "Core with LatticeIter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	assert_equal(latticeIterResult, [[p[0], [0, 0], undefined], [p[3], [0, 1], undefined], [p[1], [1, 0], undefined], [p[4], [1, 1], undefined]], "Core with LatticeIter column - FetchForEach - Bad fetchForEach(call, 5) overflow");
	
	spy.reset();
	latticeIter = new LatticeIter(p[0][0], p[0][1], p[5][0], p[5][1], 3, 2, true);
	latticeIterResult = latticeIter.fetchForEach(spy.call, 3, 4321);
	assert_equal(spy.count(), 3, "Core with LatticeIter column - FetchForEach - fetchForEach(call, 3, 4321)");
	assert_equal(latticeIterResult, [[p[0], [0, 0], 4321], [p[3], [0, 1], 4321], [p[1], [1, 0], 4321]], "Core with LatticeIter column - FetchForEach - fetchForEach(call, 3, 4321)");
	#endregion
}
