menu actions
addSubBlock: aPoint script: aScript
	| subName |
	subName := UIManager default request: 'Sub name?'.
	(subName isNil or: [ subName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript isValidSubName: subName)
		ifFalse: [ ^ UIManager default
				alert: 'invalid sub name' localized ].
	(aScript subNameInUse: subName)
		ifTrue: [ ^ UIManager default
				alert: 'sub name already in use' localized ].
	aScript addSubBlock: aPoint name: subName