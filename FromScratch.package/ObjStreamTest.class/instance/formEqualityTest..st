private
formEqualityTest: inForm
	"For testing. Serialize and deserialize the given form and compare the result for equality with the original."

	| outForm |
	outForm := self serializeAndDeserialize: inForm.
	outForm class == inForm class
		ifFalse: [ self error: 'output class is not equal to input class' ].
	outForm extent = inForm extent & (outForm depth = inForm depth)
		& (outForm bits = inForm bits) & (outForm offset = inForm offset)
		ifFalse: [ self error: 'output Form is not equal to input Form' ].
	(inForm isKindOf: ColorForm)
		ifTrue: [ inForm colors = outForm colors
				ifFalse: [ self error: 'output colors are not equal to input colors' ] ]