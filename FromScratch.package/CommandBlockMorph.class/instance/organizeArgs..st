evaluation
organizeArgs: argList
	"Answer an arugments array in which all arguments have been rearranged to the original English permutation"

	| newArgList |
	argPermutation ifNil: [^ argList].
	(#(+ - / * =) includes: selector) ifTrue: [^ argList].
	newArgList := #().
	1 to: argPermutation size do: [:i |
		newArgList := newArgList copyWith: (argList at: (argPermutation at: i))].
	^ newArgList
