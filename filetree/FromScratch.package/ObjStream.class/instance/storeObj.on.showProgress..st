entry points
storeObj: anObject on: aStream showProgress: showProgress
	"Write the given object and all the objects that can be reached from it on the given binary stream. If showProgress is true, display a progress bar."

	| sortedObjEntries i obj |
	objects := IdentityDictionary new.
	objectIndex := 1.

	"collect objects"
	stream := nil.
	firstPass := true.
	toDo := OrderedCollection new.
	self recordObject: anObject id: (self classEntryFor: anObject) first.
	[toDo size > 0] whileTrue: [self recordFieldsOf: toDo removeFirst].

	"write object table"
	stream := aStream.
	firstPass := false.
	sortedObjEntries := objects asArray sort: [:e1 :e2 | e1 first < e2 first].
	self writeFileHeader.
	stream uint32: sortedObjEntries size.
	showProgress
		ifTrue: [
			i := 0.  "object counter for progress bar"
			'Saving...'
				displayProgressFrom: 0 to: sortedObjEntries size
				during:  [:progressBar |
					sortedObjEntries do: [:objEntry |
						progressBar value: (i := i + 1).
						obj := objEntry at: 2.
						self writeObject: obj objEntry: objEntry]]]
		ifFalse: [
			sortedObjEntries do: [:objEntry |
				obj := objEntry at: 2.
				self writeObject: obj objEntry: objEntry]].
