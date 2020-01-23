private-writing
recordObject: anObject id: classID
	"Assign an ID for the given object, add it to the list of objects to be stored in the object table, and add it to the toDo list. Do nothing if this object has already been recorded."

	(objects includesKey: anObject) ifTrue: [^ self].
	objects at: anObject put: (Array with: objectIndex with: anObject with: classID with: nil).
	toDo addLast: anObject.
	objectIndex := objectIndex + 1.
