testing
isInBlockPalette
	owner ifNil: [ ^ false ].
	owner isBlockPalette ifTrue: [ ^ true ].
	owner isScriptEditor ifTrue: [ ^ false ].
	^ owner isInBlockPalette