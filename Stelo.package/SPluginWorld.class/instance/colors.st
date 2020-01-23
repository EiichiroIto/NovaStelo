accessing
colors
	| num ext |
	num := self sizeOf: SBreedId patchBreedNo.
	ext := plugin getScreen.
	^ [ ext copyFrom: 1 to: num ]
		ensure: [ ext release ]