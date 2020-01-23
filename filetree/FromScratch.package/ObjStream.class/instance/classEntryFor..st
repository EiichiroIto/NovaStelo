private-writing
classEntryFor: anObject
	"Answer the entry containing the class id and read/write selectors for the given object's class. Raise an error if the class is not registered."

	^ NameToClassEntry at: anObject class name
		ifAbsent: [self error: 'Unknown class ',  anObject class name]
