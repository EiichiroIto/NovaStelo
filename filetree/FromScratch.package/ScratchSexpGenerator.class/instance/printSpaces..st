private
printSpaces: anInteger
	anInteger timesRepeat: [ stream nextPut: Character space ].
	position := position + anInteger