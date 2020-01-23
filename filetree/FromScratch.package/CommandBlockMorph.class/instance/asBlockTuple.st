stack/tuple conversion
asBlockTuple
	"Answer a tuple (Array) describing this block and its arguments."

	| blockTuple argList arg |
	blockTuple := Array new: argMorphs size + 1.
	blockTuple at: 1 put: selector.
	argList := argMorphs.
	argList := self organizeArgs: argList.
	"((#(+ - / * =) includes: selector) and: [ScratchTranslator isRTLMath])
		ifTrue: [argList := argList reversed]."
	1 to: argList size do: [ :i | 
		arg := argList at: i.
		(arg isArgMorph) | (arg isKindOf: EventTitleMorph)
			ifTrue: [ blockTuple at: i + 1 put: arg evaluate ]
			ifFalse: [ blockTuple at: i + 1 put: arg asBlockTuple ] ].
	^ blockTuple