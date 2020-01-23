*FromScratch
indexOfSeparatorStartingAt: index
	"Answer the index of the next separator character found starting at the given index. Answer size + 1 if none is found."

	^ self
		indexOfAnyOf: CSSeparators
		startingAt: index 
		ifAbsent: [self size + 1]