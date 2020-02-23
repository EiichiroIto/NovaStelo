private
importCodes: aCollection into: aScript
	| block prev tuple top |
	prev := aScript blocksBin.
	top := nil.
	aCollection
		do: [ :each | 
			tuple := self tupleFrom: each.
			block := aScript blockFromTuple: tuple receiver: aScript.
			top
				ifNil: [ top := block.
					prev addMorph: block ]
				ifNotNil: [ prev nextBlock: block ].
			prev := block ].
	^ top