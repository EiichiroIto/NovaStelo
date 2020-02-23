menu actions
saveProject
	| fName result |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	fName := self saveScratchFileFor: project.
	fName ifNil: [ ^ self ].
	[ (result := self
		confirmFileOverwriteIfExisting: fName
		orCancel: [ ^ self ]) isNil ]
		whileTrue: [ fName := self saveScratchFileFor: project.
			fName ifNil: [ ^ self ] ].
	self saveProjectAs: result