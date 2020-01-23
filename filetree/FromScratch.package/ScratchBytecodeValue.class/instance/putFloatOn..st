private
putFloatOn: aStream
	| v |
	aStream nextPut: #pushFloat.
	v := data asFloat asIEEE32BitWord.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).