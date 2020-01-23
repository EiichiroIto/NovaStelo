private
ensurePenExists: anInteger
	anInteger > pens size
		ifTrue: [ pens := pens grownBy: anInteger - pens size.
			last
				ifNotNil: [ last := last grownBy: anInteger - last size.
					data at: data size put: last ] ].
	(pens at: anInteger)
		ifNil: [ pens at: anInteger put: (self colors atWrap: anInteger) ]