variables
addList: aString
	| vno |
	vno := breed addList: aString.
	self project addList: aString var: vno breed: breed breedNo