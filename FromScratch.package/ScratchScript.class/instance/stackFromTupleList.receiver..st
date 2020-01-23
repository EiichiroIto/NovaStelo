object i/o
stackFromTupleList: tupleList receiver: scriptOwner
	| stackTop previousBlock block |
	stackTop := previousBlock := nil.
	tupleList
		do: [ :tuple | 
			block := self blockFromTuple: tuple receiver: scriptOwner.
			previousBlock
				ifNil: [ stackTop := block ]
				ifNotNil: [ previousBlock nextBlock: block ].
			previousBlock := block ].
	^ stackTop