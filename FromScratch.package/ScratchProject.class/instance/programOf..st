accessing
programOf: aDictionary
	| program |
	program := self newProgram.
	self scripts
		do: [ :each | each setupProgram: program events: aDictionary ].
	^ program