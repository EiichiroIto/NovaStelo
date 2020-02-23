dropping/grabbing
handleReporterDrop
	"This block, a reporter, has just been dropped. Try to embed it in a command block."

	| scriptsMorph argM argOwner |
	(self isReporter and: [ owner isScriptEditor ])
		ifFalse: [ ^ self ].
	scriptsMorph := owner.
	argM := owner topArgMorphAt: self bounds exclude: self.
	(argM notNil and: [ argM acceptsTypeOf: self ])
		ifFalse: [ ^ self ].
	argM isBlockMorph
		ifTrue: [ argOwner := argM owner.
			argOwner replaceArgMorph: argM by: self.
			scriptsMorph addMorph: argM.
			argM position: (argOwner left + 90) @ (argM top - 20) ]
		ifFalse: [ argM owner replaceArgMorph: argM by: self ]