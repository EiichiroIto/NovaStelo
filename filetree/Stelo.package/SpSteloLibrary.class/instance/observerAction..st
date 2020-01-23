accessing
observerAction: aBlock
	buttonObserver
		action: [ self selectButton: buttonObserver label asString.
			aBlock cull: SBreedId observerBreedNo ]