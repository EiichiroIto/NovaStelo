program
setupEvent: aHatBlock program: aProgram table: aDictionary events: aDictionary2
	| code addr |
	aDictionary2
		at: aHatBlock eventName asSymbol
		ifPresent: [ :eventNo | 
			addr := aProgram nextAddress.
			code := project newCode
				startAddress: addr;
				subTable: aDictionary;
				parse: aHatBlock target: self.
			aProgram
				addCode: code;
				addEntryPoint: addr eventNo: eventNo breedNo: self breedNo ]