fixed format-writing
putSmallInt: anObject id: classID

	firstPass ifTrue: [^ self].
	((-32768 <= anObject) and: [anObject <= 32767])
		ifTrue: [  "optimization for integers that fit into 16 bits"
			stream nextPut: classID + 1.
			stream int16: anObject]
		ifFalse: [
			stream nextPut: classID.
			stream int32: anObject].
