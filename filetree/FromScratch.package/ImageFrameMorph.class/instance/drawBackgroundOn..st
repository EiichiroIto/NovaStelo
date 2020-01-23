drawing
drawBackgroundOn: aCanvas
	"Draw my background."

	color isTransparent ifTrue: [^ self].

	aCanvas
		fillRectangle: ((myBox origin + topLeftForm extent) corner: (myBox corner - bottomRightForm extent))
		color: color.
