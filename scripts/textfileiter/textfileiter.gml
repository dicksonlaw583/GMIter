///@func TextFileIter(filename)
///@arg {string} filename The file name to read from.
///@desc Iterator for rows in a text file.
function TextFileIter(filename) : GMIter() constructor {
	///@func hasNext()
	///@return {bool}
	///@desc Return whether there are entries to iterate.
	static hasNext = function() {
		return !is_undefined(index);
	};
	
	///@func next()
	///@desc Go to the next row of the text file.
	static next = function() {
		try {
			file_text_readln(file);
		} catch (ex) {
			throw new GMIterNextException(self); 
		}
		if (file_text_eof(file)) {
			index = undefined;
			value = undefined;
			file_text_close(file);
		} else {
			++index;
			value = file_text_read_string(file);
		}
	};
	
	///@func close()
	///@desc Close the current text file.
	static close = function() {
		if (!is_undefined(index)) {
			file_text_close(file);
		}
	};
	
	// Constructor
	file = file_text_open_read(filename);
	if (file_text_eof(file)) {
		index = undefined;
		value = undefined;
		file_text_close(file);
	} else {
		index = 0;
		value = file_text_read_string(file);
	}
}
