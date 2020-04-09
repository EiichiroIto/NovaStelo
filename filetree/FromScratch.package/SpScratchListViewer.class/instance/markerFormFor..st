private
markerFormFor: aString
	| color canvas |
	color := self target blockColorFor: aString.
	canvas := FormCanvas extent: 13 @ 13.
	canvas
		fillOval: (0 @ 0 corner: 12 @ 12)
		color: color
		borderWidth: 1
		borderColor: color darker.
	^ canvas form