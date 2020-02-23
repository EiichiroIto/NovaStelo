block specs
blockFromTuple: tuple receiver: scriptOwner
	"Answer a new block for the given tuple."

	| k spec blockColor block argCount arg argBlock |
	k := tuple first.
	(#(readVariable changeVariable) includes: k)
		ifTrue: [ ^ self variableBlockFromTuple: tuple receiver: scriptOwner ].
	(#(EventHatMorph SubHatMorph) includes: k)
		ifTrue: [ block := self hatBlockFromTuple: tuple receiver: scriptOwner.
			^ block ].
	"#scratchComment = k
		ifTrue: [ block := ScratchCommentMorph new.
			tuple size > 1
				ifTrue: [ block commentMorph contents: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			tuple size > 3
				ifTrue: [ block width: (tuple at: 4) ].
			tuple size > 4
				ifTrue: [ block anchor: (self blockWithID: (tuple at: 5)) ].
			^ block ].
	#comment: = k
		ifTrue: [ block := CommentBlockMorph new.
			tuple size > 1
				ifTrue: [ block comment: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			block color: (Color r: 0.8 g: 0 b: 0).
			^ block ]."
	spec := self blockDef blockSpecAt: k.
	spec
		ifNil: [ ^ scriptOwner
				blockFromSpec: #('obsolete!' - yourself)
				color: Color red ].
	blockColor := self blockDef blockColorAt: k.
	block := scriptOwner blockFromSpec: spec color: blockColor.
	block isCommandBlock
		ifTrue: [ argCount := block argumentCount min: tuple size - 1.
			1 to: argCount do: [ :i | 
				arg := tuple at: i + 1.
				arg isArray
					ifTrue: [ "argument is a block"
						(arg size = 1 and: [ arg first isArray ])
							ifTrue: [ arg := arg first ].
						argBlock := self blockFromTuple: arg receiver: scriptOwner.
						block replaceArgMorph: (block argumentAt: i) by: argBlock ]
					ifFalse: [ "argument is a value" (block argumentAt: i) defaultValue: arg ] ].
			block isCBlock
				ifTrue: [ tuple last isArray
						ifTrue: [ block
								firstBlockList: (self stackFromTupleList: tuple last receiver: scriptOwner) ] ].
			block isIfElseBlock
				ifTrue: [ arg := tuple at: tuple size - 1.
					arg isArray
						ifTrue: [ block
								trueBlock: (self stackFromTupleList: arg receiver: scriptOwner) ].
					arg := tuple at: tuple size.
					arg isArray
						ifTrue: [ block
								falseBlock: (self stackFromTupleList: arg receiver: scriptOwner) ] ].
			block isReporter
				ifTrue: [ ((spec at: 2) includes: $b)
						ifTrue: [ block isBoolean: true ] ] ].
	^ block