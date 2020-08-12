argument menus
updateListArgFor: aBlock
	| listVar |
	listVar := self listVarNames
		ifEmpty: [ ^ self ]
		ifNotEmpty: [ :l | l first ].
	aBlock argMorphs
		do: [ :each | 
			((each isKindOf: ChoiceArgMorph)
				and: [ each getOptionsSelector = #listVarNames ])
				ifTrue: [ each defaultValue: listVar ] ]