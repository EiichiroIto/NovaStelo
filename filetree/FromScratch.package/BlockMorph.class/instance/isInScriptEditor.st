testing
isInScriptEditor
	owner ifNil: [ ^ false ].
	owner isBlockPalette ifTrue: [ ^ false ].
	owner isScriptEditor ifTrue: [ ^ true ].
	^ owner isInScriptEditor