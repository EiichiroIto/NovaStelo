private
setAllVariables: aBreed
	| bno |
	bno := aBreed breedNo.
	aBreed realVarNames
		do: [ :each | 
			| vno list |
			vno := aBreed varNoFor: each.
			list := aBreed varArrayNamed: each.
			self setAllVariable: vno breed: bno list: list ]