accessing
addChoiceArg: aCharacter selector: aSymbol
	self
		add: aCharacter
		builder: [ ChoiceArgMorph new
				getOptionsSelector: aSymbol;
				getOptionsTarget: nil;
				choice: '' ]