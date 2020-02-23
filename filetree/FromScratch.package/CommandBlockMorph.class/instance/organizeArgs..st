evaluation
organizeArgs: argList
	"Answer an arugments array in which all arguments have been rearranged to the original English permutation"

	argPermutation ifNil: [ ^ argList ].
	(#(+ - / * =) includes: selector)
		ifTrue: [ ^ argList ].
	^ argPermutation collect: [ :each | argList at: each ]