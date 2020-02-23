stack/tuple conversion
asBlockTuple
	"Answer a tuple (Array) describing this block and its arguments."

	| stream |
	stream := WriteStream on: Array new.
	stream nextPut: selector.
	(self organizeArgs: argMorphs)
		do: [ :each | 
			stream
				nextPut:
					(each isArgMorph | (each isKindOf: EventTitleMorph)
						ifTrue: [ each evaluate ]
						ifFalse: [ each asBlockTuple ]) ].
	^ stream contents