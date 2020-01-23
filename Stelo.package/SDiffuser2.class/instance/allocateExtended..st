private
allocateExtended: anInteger
	(extented notNil and: [anInteger <= extented size])
		ifTrue: [ ^ self ].
	extented := FloatArray new: anInteger.