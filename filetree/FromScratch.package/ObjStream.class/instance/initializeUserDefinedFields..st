private-reading
initializeUserDefinedFields: objectRecord
	"If the given object record designates a user-defined object, ask that object to initialiize itself from its fields list. Otherwise, do nothing."

	| obj classID classVersion |
	obj := objectRecord at: 1.
	classID := objectRecord at: 2.
	classID > ObjectReferenceID ifTrue: [  "user defined class"
		classVersion := objectRecord at: 3.
		fields := objectRecord at: 4.
		fieldIndex := 0.
		obj initFieldsFrom: self version: classVersion].
