accessing
color

	frame ifNotNil: [^ frame color].
	^ color = Color transparent
		ifTrue: [owner color]
		ifFalse: [color]

