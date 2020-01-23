button actions
deleteList: aScript
	"Ask the user which user variable to delete, then remove it."

	| list choice |
	list := aScript listVarNames.
	list isEmpty
		ifTrue: [ ^ UIManager default alert: 'No lists.' localized ].
	choice := MenuMorph chooseFrom: list lines: #() title: ''.
	choice = 0
		ifTrue: [ ^ self ].
	aScript deleteList: (list at: choice).
	presenter currentCategory: #variables