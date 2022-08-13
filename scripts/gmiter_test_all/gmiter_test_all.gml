///@func gmiter_test_all()
function gmiter_test_all() {
	global.__test_fails__ = 0;
	var timeA, timeB;
	timeA = current_time;
	
	/* v Tests here v */
	gmiter_test_nothing();
	gmiter_test_drone();
	gmiter_test_times();
	/* ^ Tests here ^ */
	
	timeB = current_time;
	show_debug_message("GMIter tests done in " + string(timeB-timeA) + "ms.");
	return global.__test_fails__ == 0;
}
