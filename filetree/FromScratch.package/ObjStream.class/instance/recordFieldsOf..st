private-writing
recordFieldsOf: anObject
	"Record the fields of the given object."
	"Details: Sometimes a user-defined class creates an object dynamically in a call to putField:. To preserve object identity between passes one and two, the objects passed to all calls to putField: are recorded during the first pass (i.e., by this method) and those exact same objects are used in the second pass."

	| entry classID putSelector |
	entry := self classEntryFor: anObject.
	classID := entry at: 1.
	putSelector := entry at: 4.

	fields := OrderedCollection new.
	fieldIndex := 0.
	self perform: putSelector with: anObject with: classID.
	(objects at: anObject) at: 4 put: fields asArray.
