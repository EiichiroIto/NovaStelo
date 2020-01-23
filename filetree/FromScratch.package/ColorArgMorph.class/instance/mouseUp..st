event handling
mouseUp: evt

	| w palette |
	showPalette ifNil: [showPalette := true].

	(w := self world) ifNil: [^ self].
	showPalette ifTrue: [
		palette := ImageMorph new form: ColorPalette.
		palette position: self bounds bottomLeft + (0@5).
		w addMorph: palette.
		w displayWorldSafely].

	self pickColor.

	palette ifNotNil: [palette delete].
