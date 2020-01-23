accessing
putShort: anInteger on: aStream
	| v |
	aStream nextPut: #pushShort.
	v := anInteger >= 0
		ifTrue: [ anInteger ]
		ifFalse: [ 16r10000 + anInteger ].
	aStream nextPut: (v bitAnd: 16rFF).
	v := v >> 8.
	aStream nextPut: (v bitAnd: 16rFF).