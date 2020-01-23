fixed format-reading
getConst: anObject id: classID

	classID = 1 ifTrue: [^ nil].
	classID = 2 ifTrue: [^ true].
	classID = 3 ifTrue: [^ false].
