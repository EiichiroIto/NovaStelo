menu actions
addSubBlock: anEvent script: aScript
	| subName |
	subName := UIManager default request: 'Sub name?'.
	(subName isNil or: [ subName isEmpty ])
		ifTrue: [ ^ self ].
	aScript addSubBlock: anEvent cursorPoint name: subName