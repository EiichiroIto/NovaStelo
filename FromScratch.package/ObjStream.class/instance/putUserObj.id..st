private-writing
putUserObj: anObject id: ignored
	"Ask the given user-defined object to write it's fields."

	anObject storeFieldsOn: self.
