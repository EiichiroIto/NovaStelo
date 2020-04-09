menu actions
showScriptMenu: aScript event: anEvent
	(presenter scriptMenuFor: aScript)
		openWithSpecAt: anEvent cursorPoint