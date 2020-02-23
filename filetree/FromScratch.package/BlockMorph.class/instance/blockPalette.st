accessing
blockPalette
	owner ifNil: [ ^ nil ].
	owner isBlockPalette ifTrue: [ ^ owner ].
	owner isScriptEditor ifTrue: [ ^ nil ].
	^ owner blockPalette