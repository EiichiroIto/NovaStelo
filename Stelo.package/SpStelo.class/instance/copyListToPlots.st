menu actions
copyListToPlots
	| listNames observerScript plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	observerScript := project scriptOf: SBreedId observerBreedNo.
	plots := (1 to: observerScript plotter numPlots + 1) asArray.
	ret := SpSteloConvDialog listNames: listNames plots: plots.
	ret ifNil: [ ^ self ].
	vno := project observer varNoFor: ret first.
	list := sworld var: vno breed: SBreedId observerBreedNo list: 1.
	observerScript plotter plot: ret second list: list