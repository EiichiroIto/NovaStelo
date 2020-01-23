accessing
defaultArgs: defaultValues
	"Set the default values of my arguments from the given list."

	| argM defaultValue |
	1 to: (defaultValues size min: argMorphs size) do: [:i |
		argM := argMorphs at: (argPermutation at: i).
		defaultValue := defaultValues at: i.
		(argM  isKindOf: ExpressionArgMorph)
			ifTrue: [argM defaultValueFromSpec: defaultValue]
			ifFalse: [argM defaultValue: defaultValue]].

