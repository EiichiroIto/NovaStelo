accessing
filename
	| ret |
	ret := textFilename pendingText asString.
	^ ret ifEmpty: [ nil ] ifNotEmpty: [ fileList directory / ret ]