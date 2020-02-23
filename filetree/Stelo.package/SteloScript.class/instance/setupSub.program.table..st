program
setupSub: aHatBlock program: aProgram table: aDictionary
	| code addr |
	addr := aProgram nextAddress.
	code := project newCode
		startAddress: addr;
		subTable: aDictionary;
		parse: aHatBlock target: self.
	aProgram addCode: code.
	aDictionary at: aHatBlock subName put: addr