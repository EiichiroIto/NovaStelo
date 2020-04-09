menu actions
copyPlotsToList
	| listNames observerScript plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	observerScript := project scriptOf: SBreedId observerBreedNo.
	plots := (1 to: self plotter numPlots) asArray.
	ret := SpSteloConvDialog plots: plots listNames: listNames.
	ret ifNil: [ ^ self ].
	list := self plotter listOf: ret first.
	vno := project observer varNoFor: ret second.
	sworld
		var: vno
		breed: SBreedId observerBreedNo
		list: 1
		set: list