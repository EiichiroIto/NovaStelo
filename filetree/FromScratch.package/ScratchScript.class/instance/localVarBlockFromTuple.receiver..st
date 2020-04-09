blocks
localVarBlockFromTuple: tuple receiver: scriptOwner
	| varName rcvr |
	varName := tuple at: 2.
	rcvr := scriptOwner.
	^ LocalVarBlockMorph new
		commandSpec: varName;
		receiver: rcvr