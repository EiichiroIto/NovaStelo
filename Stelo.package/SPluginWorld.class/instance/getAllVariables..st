private
getAllVariables: aBreed
	| bno |
	bno := aBreed breedNo.
	aBreed realVarNames
		do: [ :each | 
			| vno list |
			vno := aBreed varNoFor: each.
			list := self getAllVariable: vno breed: bno.
			list ifNotNil: [ aBreed varArrayNamed: each put: list ] ]