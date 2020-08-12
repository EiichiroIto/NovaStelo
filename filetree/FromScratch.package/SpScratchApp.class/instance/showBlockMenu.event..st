menu actions
showBlockMenu: aBlockMorph event: anEvent
	| menu |
	menu := presenter
		blockMenuFor: aBlockMorph
		inScriptEditor: aBlockMorph isInScriptEditor.
	menu ifNil: [ ^ self ].
	menu openWithSpecAt: anEvent cursorPoint