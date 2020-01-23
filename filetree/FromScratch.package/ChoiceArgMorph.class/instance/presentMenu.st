accessing
presentMenu
	"Pop up a menu of choices."

	| optionList doLocalization menu selection option |
	optionList := self options.
	optionList size = 0
		ifTrue: [ ^ self ].
	doLocalization := (#(varNames ) includes: getOptionsSelector) not.
	menu := MenuMorph new.
	menu target: [ :v | selection := v ].
	optionList
		do: [ :sym | 
			'-' = sym
				ifTrue: [ menu addLine ]
				ifFalse: [ doLocalization
						ifTrue: [ option := sym localized ]
						ifFalse: [ option := sym ].
					menu add: option selector: #value: argument: sym ] ].
	menu invokeAt: ActiveHand position in: self world.
	selection ifNotNil: [ self choice: selection ].