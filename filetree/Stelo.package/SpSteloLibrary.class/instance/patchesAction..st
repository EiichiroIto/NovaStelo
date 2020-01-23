accessing
patchesAction: aBlock
	buttonPatches
		action: [ self selectButton: buttonPatches label asString.
			aBlock cull: SBreedId patchBreedNo ]