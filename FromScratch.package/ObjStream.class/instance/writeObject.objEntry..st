private-writing
writeObject: anObject objEntry: objEntry
	"Write the object described by the given entry."

	| entry classID putSelector |
	entry := self classEntryFor: anObject.
	classID := entry at: 1.
	putSelector := entry at: 4.

	fields := objEntry at: 4.
	fieldIndex := 0.

	putSelector = #putUserObj:id: ifTrue: [
		stream nextPut: classID.
		stream nextPut: anObject fieldsVersion.
		stream nextPut: fields size].

	self perform: putSelector with: anObject with: classID.
