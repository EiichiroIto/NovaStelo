patch ops
getObserverVar: var
	^ bcGenerator
		getObserverVar: (targetMorph observerVarId varNoFor: var choice)