button actions
addList: aScript
	| listName |
	listName := UIManager default request: 'List name?' localized.
	(listName isNil or: [ listName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript variableNameInUse: listName)
		ifTrue: [ ^ UIManager default
				alert: 'That list name is already in use!' localized ].
	aScript addList: listName.
	presenter currentCategory: #variables