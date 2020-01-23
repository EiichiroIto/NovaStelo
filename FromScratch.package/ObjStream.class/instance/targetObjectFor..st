private-reading
targetObjectFor: anObject
	"If the argument is an ObjRefRecord, answer the object that it refers to. Otherwise, just answer the argument."

	anObject class = ObjRefRecord
		ifTrue: [^ (objects at: anObject objectID) first]
		ifFalse: [^ anObject].
