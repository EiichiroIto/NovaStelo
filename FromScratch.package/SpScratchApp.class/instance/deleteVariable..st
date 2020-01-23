button actions
deleteVariable: aScript
	"Ask the user which user variable to delete, then remove it."

	| menu choice |
	aScript varNames isEmpty
		ifTrue: [ ^ UIManager default alert: 'No variables.' localized ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	aScript varNames
		do: [ :v | menu add: v selector: #value: argument: v ].
	menu invokeModal: true.
	choice ifNil: [ ^ self ].
	aScript deleteVariable: choice.
	presenter currentCategory: #variables