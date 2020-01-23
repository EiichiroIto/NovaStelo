utilities
argPermutationForSpec: spec withTranslation: translatedSpec
	"CommandBlockMorph argPermutationForSpec: '%a of %m of %m of %t' withTranslation: '%a de %m de %m de %t'"
	"CommandBlockMorph argPermutationForSpec: '%a of %m of %m of %t' withTranslation: '%t de %m2 de %m1 de %a'"

	| parsedSpec parsedTranslatedSpec parsedSpecArgs parsedTranslatedSpecArgs permutation a copiesSize n originalPermutation |

	parsedSpec := CommandBlockMorph parseCommandSpec: spec.
	parsedSpecArgs := parsedSpec select: [:s | CommandBlockMorph isArgSpec: s].
	parsedTranslatedSpec := CommandBlockMorph parseCommandSpec: translatedSpec.
	parsedTranslatedSpecArgs := parsedTranslatedSpec select: [:s | CommandBlockMorph isArgSpec: s].

	permutation := #().
	1 to: parsedSpecArgs size do: [:i | permutation := permutation copyWith: i].
	originalPermutation := permutation.

	"no change"
	(parsedSpecArgs = parsedTranslatedSpecArgs) ifTrue: [
			^ originalPermutation].

	"otherwise, calculate permutation"
	1 to: parsedSpecArgs size do: [:i |
		a := parsedSpecArgs at: i.
		copiesSize := (parsedSpecArgs select: [:s | (s = a)]) size.
		(copiesSize = 1)
			ifTrue:[permutation at: i put: (parsedTranslatedSpecArgs indexOf: a
				ifAbsent: [Transcript show: 'Permutation failed: ', spec.
						^ originalPermutation])]
			ifFalse:["count copies until now"
				n := ((parsedSpecArgs copyFrom: 1 to: i) select: [:s | (s = a)]) size.
				permutation at: i put: (parsedTranslatedSpecArgs indexOf: (a,n asString)
					ifAbsent: [Transcript show: 'Permutation failed: ', spec.
						^ originalPermutation])]].
	^ permutation
