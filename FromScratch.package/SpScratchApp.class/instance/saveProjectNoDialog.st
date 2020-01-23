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
	project
		thumbnailForm: (presenter stageShotExtent: self class thumbnailExtent).
	(project writeProjectAs: file)
		ifFalse: [ ^ self ].
	self projectName: file base.
	self projectDirectory: file parent