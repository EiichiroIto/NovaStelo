menu actions
saveProjectNoDialog
	| fName dir file |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	fName := self projectName.
	dir := ScratchDirectory current getLastFolderForType: #project.
	file := dir / (fName , '.' , self extension).
	file isFile
		ifFalse: [ ^ self saveProject ].
	ScratchDirectory current lastFolderIsSampleProjectsFolder
		ifTrue: [ self projectDirectory: ScratchDirectory current project.
			^ self saveProject ].
	self saveProjectAs: file