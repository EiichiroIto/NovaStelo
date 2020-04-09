accessing
addChoiceArg: aCharacter selector: aSymbol target: anObject initialChoice: aString
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: anObject;
				choice: aString ]