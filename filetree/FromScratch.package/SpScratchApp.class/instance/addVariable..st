button actions
addVariable: aScript
	| varName |
	varName := UIManager default request: 'Variable name?' localized.
	(varName isNil or: [ varName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript variableNameInUse: varName)
		ifTrue: [ ^ UIManager default
				alert: 'That variable name is already in use' localized ].
	aScript addVariable: varName.
	presenter currentCategory: #variables