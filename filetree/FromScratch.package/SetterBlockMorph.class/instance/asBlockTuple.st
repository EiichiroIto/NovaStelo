private
asBlockTuple
	"Answer a tuple (Array) describing this block and its arguments."

	| result arg |
	result := Array with: #changeVariable with: self variable with: selector with: nil.

	arg := (argMorphs first isKindOf: ChoiceArgMorph)
		ifTrue: [argMorphs last]
		ifFalse: [argMorphs first].

	(arg isKindOf: ArgMorph)
		ifTrue: [result at: 4 put: arg evaluate]
		ifFalse: [result at: 4 put: arg asBlockTuple].

	^ result

