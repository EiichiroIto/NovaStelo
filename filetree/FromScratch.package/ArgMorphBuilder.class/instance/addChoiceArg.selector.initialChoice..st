accessing
addChoiceArg: aCharacter selector: aSymbol initialChoice: aString
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: aString ]