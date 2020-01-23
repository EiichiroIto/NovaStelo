private
addVariablesFor: aBreed
	| bno |
	bno := aBreed breedNo.
	aBreed userDefinedVarNoAndNames
		do: [ :each | plugin addVariable: each first breed: bno ].