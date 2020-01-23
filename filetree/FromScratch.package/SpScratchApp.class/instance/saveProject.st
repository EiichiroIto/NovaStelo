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
	project
		thumbnailForm: (presenter stageShotExtent: self class thumbnailExtent).
	(project writeProjectAs: result)
		ifFalse: [ ^ self ].
	self projectName: result base.
	self projectDirectory: result parent