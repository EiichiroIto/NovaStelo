evaluation
coerceArgs: argList
	"Answer an arugments array in which all arguments that should be numbers have been coerced to numbers if necessary."

	| args specialCommands |
	args := argList asArray.
	(self script specialCommands includes: selector)
		ifFalse: [ "ensure args are numbers where numbers are expected"
			args := argList asArray
				with: self numberArgFlags
				collect: [ :each :flag | 
					flag
						ifTrue: [ each asNumberNoError ]
						ifFalse: [ each ] ] ].
	^ args