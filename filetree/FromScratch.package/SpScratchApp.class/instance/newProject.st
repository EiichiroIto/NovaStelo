menu actions
newProject
	| response |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	(project notNil and: [ project modified ])
		ifTrue: [ response := UIManager default
				confirm: 'Save the current project?' localized
				orCancel: [ ^ self ].
			response
				ifTrue: [ self saveProjectNoDialog ] ].
	self
		projectDirectory: (ScratchDirectory current getDefaultFolderForType: #project).
	self projectName: 'New Project'.
	self installNewProject: self createProject