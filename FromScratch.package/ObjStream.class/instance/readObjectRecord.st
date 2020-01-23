private-reading
readObjectRecord
	"Read the next object record. Answer an array of the form (<obj> <class ID> [<version> <fieldsArray>]). The version and fields array are supplied only for user-defined objects."

	| classID obj classVersion fieldCount fieldList readSelector |
	classID := stream next.
	classID > ObjectReferenceID
		ifTrue: [  "user defined object"
			obj := (self classForID: classID) new.
			classVersion := stream next.
			fieldCount := stream next.
			fieldList := (1 to: fieldCount) collect: [:i | self readField].
			^ Array with: obj with: classID with: classVersion with: fieldList]
		ifFalse: [  "fixed format object"
			readSelector := (IDToClassEntry at: classID) at: 3.
			obj := self perform: readSelector with: nil with: classID.
			^ Array with: obj with: classID].
