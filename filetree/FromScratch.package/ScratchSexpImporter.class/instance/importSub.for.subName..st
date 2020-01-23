private
importSub: aCollection for: aScript subName: aString
	| block prev tuple |
	prev := aScript blocksBin.
	tuple := self subBlockTupleFor: aString.
	block := aScript hatBlockFromTuple: tuple receiver: aScript.
	prev addMorph: block.
	prev := block.
	aCollection
		do: [ :each | 
			tuple := self tupleFrom: each.
			block := aScript blockFromTuple: tuple receiver: aScript.
			prev nextBlock: block.
			prev := block ]