drawing
drawOn: aCanvas
	"Fill with my texture patch. Fill with a solid color if there is no texture in the current skin dictionary."

	| patchF clipC y x |
	self isScreenshooting
		ifTrue: [ aCanvas fillRectangle: self bounds color: Color transparent.
			^ self ].
	patchF := ScratchTheme formAt: #scriptsPaneTexture.
	clipC := aCanvas copyClipRect: self bounds.
	y := self top.
	[ y <= self bottom ]
		whileTrue: [ x := self left.
			[ x <= self right ]
				whileTrue: [ clipC paintImage: patchF at: x @ y.
					x := x + patchF width ].
			y := y + patchF height ]