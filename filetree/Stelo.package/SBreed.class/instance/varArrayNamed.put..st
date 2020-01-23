accessing variable
varArrayNamed: aString put: aCollection
	| vno |
	vno := self varNoFor: aString.
	^ variables setVar: vno toArray: aCollection