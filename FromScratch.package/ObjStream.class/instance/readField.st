private-reading
readField
	"Read a single object field. The result may be an object or an object reference."

	| classID readSelector |
	classID := stream next.
	classID = ObjectReferenceID ifTrue: [
		^ ObjRefRecord new objectID: stream uint24].

	readSelector := (IDToClassEntry at: classID) at: 3.
	^ self perform: readSelector with: nil with: classID
