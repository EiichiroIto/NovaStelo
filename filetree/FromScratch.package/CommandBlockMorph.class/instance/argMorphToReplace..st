private
argMorphToReplace: aMorph
	"Answer a new argument morph to be used to replace the given morph. Answer nil if the given morph is not one of my argMorphs."

	| i argSpecs spec argM defaults v |
	i := argMorphs indexOf: aMorph ifAbsent: [ ^ nil ].
	argSpecs := self argSpecs.
	i > argSpecs size
		ifTrue: [ ^ nil ].
	argM := self argMorphFor: (argSpecs at: i).
	(#setVar:to: = selector and: [ (argSpecs at: i) = '%n' ])
		ifTrue: [ ^ argM stringExpression: '0' ].
	spec := self script blockSpecAt: selector.
	spec ifNil: [ ^ argM ].
	defaults := receiver defaultArgsFor: spec.
	i <= defaults size
		ifTrue: [ v := defaults at: (argPermutation indexOf: i).
			v isString
				ifTrue: [ argM isExpressionArg
						ifTrue: [ argM defaultValueFromSpec: v localized ]
						ifFalse: [ argM defaultValue: v localized ] ]
				ifFalse: [ argM defaultValue: v ] ].
	^ argM