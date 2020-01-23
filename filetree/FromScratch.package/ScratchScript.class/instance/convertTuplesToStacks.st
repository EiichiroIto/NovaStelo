object i/o
convertTuplesToStacks
	| tuplesList stack |
	blocksBin isArray
		ifFalse: [ ^ self ].
	tuplesList := blocksBin.
	blocksBin := ScratchScriptsMorph new.
	tuplesList
		do: [ :pair | 
			stack := self stackFromTupleList: pair second receiver: self.
			stack position: pair first.
			blocksBin addMorph: stack ]