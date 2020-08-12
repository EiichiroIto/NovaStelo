menu actions
quit
	(self confirm: 'Quit Application?' localized)
		ifFalse: [ ^ self ].
	Smalltalk snapshot: false andQuit: true