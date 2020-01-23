private
asBlockTuple
	"Answer a tuple (Array) describing this block and its arguments."

	| blockTuple arg argList |
	blockTuple := Array new: argMorphs size + 2.
	blockTuple at: 1 put: selector.

	argList := argMorphs.
	argList := self organizeArgs: argList.
	1 to: argList size do: [:i |
		arg := argList at: i.
		(arg isKindOf: ArgMorph)
			ifTrue: [blockTuple at: i + 1 put: arg evaluate]
			ifFalse: [blockTuple at: i + 1 put: arg asBlockTuple]].

	nestedBlock
		ifNil: [blockTuple at: blockTuple size put: nil]
		ifNotNil: [blockTuple at: blockTuple size put: nestedBlock tupleSequence].

	^ blockTuple
