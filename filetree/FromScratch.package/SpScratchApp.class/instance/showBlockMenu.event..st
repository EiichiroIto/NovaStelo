menu actions
showBlockMenu: aBlockMorph event: anEvent
	(presenter
		blockMenuFor: aBlockMorph
		inScriptEditor: aBlockMorph isInScriptEditor)
		openWithSpecAt: anEvent cursorPoint