fixed format-reading
getSmallInt: anObject id: classID

	classID = 4 ifTrue: [^ stream int32].
	classID = 5 ifTrue: [^ stream int16].
