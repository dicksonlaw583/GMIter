///@func gmiter_test_all()
function gmiter_test_all() {
	global.__test_fails__ = 0;
	var timeA, timeB;
	timeA = current_time;
	
	/* v Tests here v */
	gmiter_test_nothing();
	gmiter_test_drone();
	gmiter_test_times();
	gmiter_test_array();
	gmiter_test_struct();
	gmiter_test_ds_map();
	gmiter_test_ds_list();
	gmiter_test_text_file();
	gmiter_test_csv_file_array();
	gmiter_test_csv_file_struct();
	/* ^ Tests here ^ */
	
	timeB = current_time;
	show_debug_message("GMIter tests done in " + string(timeB-timeA) + "ms.");
	return global.__test_fails__ == 0;
}
