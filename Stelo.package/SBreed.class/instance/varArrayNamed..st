accessing variable
varArrayNamed: aString
	| vno |
	vno := self varNoFor: aString.
	^ variables realArrayAt: vno