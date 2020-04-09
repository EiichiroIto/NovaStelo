accessing
addLocalVarArg: aCharacter initialVarName: aString
	self
		add: aCharacter
		builder: [ LocalVarArgMorph new varName: aString ]