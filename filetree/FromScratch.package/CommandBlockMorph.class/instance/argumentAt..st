evaluation
argumentAt: index
	"Returns the argument morph at the given index."

	^ argMorphs at: (argPermutation at: index).
