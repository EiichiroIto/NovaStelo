variables
addVariable: aString
	| vno |
	vno := breed addVariable: aString.
	self project addVariable: aString var: vno breed: breed breedNo