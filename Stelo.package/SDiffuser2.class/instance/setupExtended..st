private
setupExtended: anArray
	| src dst |
	src := ReadStream on: anArray.
	dst := WriteStream on: extented.
	order + 2 timesRepeat: [ dst nextPut: 0 ].
	order
		timesRepeat: [ dst nextPut: 0.
			order timesRepeat: [ dst nextPut: src next ].
			dst nextPut: 0 ].
	order + 2 timesRepeat: [ dst nextPut: 0 ]