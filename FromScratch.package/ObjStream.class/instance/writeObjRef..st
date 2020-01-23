private-writing
writeObjRef: anObject
	"Write a reference to the given object to my output stream. The object must have an entry in the object dictionary."

	| objEntry objIndex |
	objEntry := objects at: anObject ifAbsent: [self error: 'object not in dictionary'].  "should never happen"
	objIndex := objEntry at: 1.
	stream nextPut: ObjectReferenceID.
	stream uint24: objIndex.
