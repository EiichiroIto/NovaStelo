menu actions
quit
	(self confirm: 'Quit Application?' translated)
		ifFalse: [ ^ self ].
	Smalltalk snapshot: false andQuit: true