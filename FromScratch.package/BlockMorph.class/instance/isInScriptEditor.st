testing
isInScriptEditor
	owner ifNil: [ ^ false ].
	owner isScriptEditor ifTrue: [ ^ true ].
	^ owner isInScriptEditor