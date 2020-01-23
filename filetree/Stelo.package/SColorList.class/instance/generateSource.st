private
generateSource
	| w |
	w := WriteStream on: ''.
	colors
		withIndexDo: [ :each :index | 
			w
				nextPutAll: 'color[';
				nextPutAll: (index - 1) asString;
				nextPutAll: '] = RGB(';
				nextPutAll: (each red * 255) truncated asString;
				nextPutAll: ',';
				nextPutAll: (each green * 255) truncated asString;
				nextPutAll: ',';
				nextPutAll: (each blue * 255) truncated asString;
				nextPutAll: ');';
				nextPutAll: String lf ].
	^ w contents