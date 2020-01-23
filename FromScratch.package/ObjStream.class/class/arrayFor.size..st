accessing
arrayFor: id size: size
	| classSymbol |
	classSymbol := (IDToClassEntry at: id) second.
	classSymbol = #Array ifTrue: [ ^ Array new: size ].
	classSymbol = #FloatArray ifTrue: [ ^ FloatArray new: size ].
	classSymbol = #IntegerArray ifTrue: [ ^ IntegerArray new: size ].
	self error: 'Invalid Array'