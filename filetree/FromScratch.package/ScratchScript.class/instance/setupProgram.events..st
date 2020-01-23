program
setupProgram: aProgram events: aDictionary
	| subTable |
	subTable := Dictionary new.
	self subBlocks
		do: [ :each | 
			self
				setupSub: each
				program: aProgram
				table: subTable ].
	self eventBlocks
		do: [ :each | 
			self
				setupEvent: each
				program: aProgram
				table: subTable
				events: aDictionary ].