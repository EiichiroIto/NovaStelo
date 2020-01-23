private-reading
fixReferencesForObjectRecord: objectRecord
	"After reading all the objects in the objects table, this method is called on each object record to replace all its object references with pointers to the actual object in the object table. The fields for user-defined objects are still held in an array in the object table record. Fixed-format objects are processed by calling their read selector a second time and, since firstPass is now false, this read method fixes any object references."

	| obj classEntry classID readSelector |
	obj := objectRecord first.
	classEntry := self classEntryFor: obj.
	classID := classEntry first.

	classID >= FirstPointerClassID ifTrue: [
		classID > ObjectReferenceID
			ifTrue: [  "user defined class"
				self fixRefsInArray: (objectRecord at: 4)]
			ifFalse: [  "fixed format class"
				readSelector := classEntry at: 3.
				self perform: readSelector with: obj with: classID]].
