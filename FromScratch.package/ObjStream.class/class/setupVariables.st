class initialization
setupVariables
	"self setupVariables"

	| entry2 |
	ObjectReferenceID := 99.
	IDToClassEntry := Dictionary new.
	NameToClassEntry := Dictionary new.
	self fixedFormatClasses
		do: [ :entry | 
			(IDToClassEntry includesKey: entry first)
				ifTrue: [ self error: 'duplicate fixed class ID' ].
			IDToClassEntry at: entry first put: entry.
			NameToClassEntry at: entry second put: entry ].
	self userClasses
		do: [ :pair | 
			entry2 := pair , #(unused #putUserObj:id:).
			(IDToClassEntry includesKey: entry2 first)
				ifTrue: [ self error: 'duplicate user class ID' ].
			IDToClassEntry at: entry2 first put: entry2.
			NameToClassEntry at: entry2 second put: entry2 ].
	FloatClassID := (NameToClassEntry at: #BoxedFloat64) first.
	FirstPointerClassID := (NameToClassEntry at: #Array) first.
	NameToClassEntry at: #ByteSymbol put: (NameToClassEntry at: #Symbol)