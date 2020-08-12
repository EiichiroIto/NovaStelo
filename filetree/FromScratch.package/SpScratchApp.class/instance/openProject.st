menu actions
openProject
	| response newProj |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	(project notNil and: [ project modified ])
		ifTrue: [ response := UIManager default
				confirm: 'Save the current project?' localized
				orCancel: [ ^ self ].
			response
				ifTrue: [ self saveProjectNoDialog ] ].
	response := self openScratchFileFor: self createProject.
	response ifNil: [ ^ self ].
	newProj := self createProject readProjectFrom: response.
	newProj ifNil: [ ^ self ].
	self projectDirectory: response parent.
	self projectName: response base.
	self installNewProject: newProj