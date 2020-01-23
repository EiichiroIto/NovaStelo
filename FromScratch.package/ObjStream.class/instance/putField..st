entry points
putField: anObject
	"Put the given object. If the given object is nil, true, false, an integer, or a float, it is stored directly. Otherwise, it is stored as an object reference and the object will be stored exactly once no matter how many other objects refer to it."

	| entry classID putSelector |
	entry := self classEntryFor: anObject.
	classID := entry at: 1.
	putSelector := entry at: 4.

 	firstPass ifTrue: [fields addLast: anObject].
	fieldIndex := fieldIndex + 1.

	classID <= FloatClassID ifTrue: [  "store the value directly inline"
		firstPass ifFalse: [self perform: putSelector with: anObject with: classID].
		^ self].
	
	firstPass
		ifTrue: [self recordObject: anObject id: classID]
		ifFalse: [self writeObjRef: (fields at: fieldIndex)].
