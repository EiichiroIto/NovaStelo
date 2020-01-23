drawing
drawString: aString at: aPoint on: aCanvas
	| s |
	s := aString.
	suppressAntiAliasing ifNil: [ suppressAntiAliasing := false ].
	renderWithSqueak ifNil: [ renderWithSqueak := false ].
	aCanvas
		drawString: s
		in: (aPoint extent: 10000 @ 10000)
		font: font
		color: textColor