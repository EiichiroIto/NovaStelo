fixed format-reading
getFloat: anObject id: classID

	| result |
	result := Float new: 2.
	result basicAt: 1 put: stream uint32.
	result basicAt: 2 put: stream uint32.
	^ result
