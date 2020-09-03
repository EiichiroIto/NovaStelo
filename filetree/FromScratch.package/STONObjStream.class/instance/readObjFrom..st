entry points
readObjFrom: aStream
	"Read the root object from the given binary stream."

	^ self readObjFrom: aStream showProgress: false