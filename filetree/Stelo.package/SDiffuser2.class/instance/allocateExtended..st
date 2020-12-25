private
allocateExtended: anInteger
	(extented notNil and: [anInteger <= extented size])
		ifTrue: [ ^ self clearExtended ].
	extented := FloatArray new: anInteger.