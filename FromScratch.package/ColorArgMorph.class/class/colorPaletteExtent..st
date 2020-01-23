class initialization
colorPaletteExtent: extent
	"Answer a form containing a palette of colors sorted horizontally by hue and vertically by lightness."
	"(self colorPaletteExtent: 180@100) display"

	| palette grayWidth startHue vSteps hSteps x basicHue y c |
	palette := Form extent: extent depth: 32.
	grayWidth := 10.
	startHue := 338.0.
	vSteps := palette height // 2.
	hSteps := palette width - grayWidth.
	x := 0.
	startHue to: startHue + 360.0 by: 360.0 / hSteps do: [:h |
		basicHue := Color h: h asFloat s: 1.0 v: 1.0.
		y := 1.
		0 to: vSteps do: [:n |
 			c := basicHue mixed: (n asFloat / vSteps asFloat) with: Color white.
			palette fill: (x@y extent: 1@1) fillColor: c.
			y := y + 1].
		1 to: vSteps do: [:n |
 			c := Color black mixed: (n asFloat / vSteps asFloat) with: basicHue.
			palette fill: (x@y extent: 1@1) fillColor: c.
			y := y + 1].
		x := x + 1].

	y := 1.
	1 to: vSteps * 2 do: [:n |
 		c := Color black mixed: (n asFloat / (2 * vSteps) asFloat) with: Color white.
		palette fill: (x@y extent: 10@1) fillColor: c.
		y := y + 1].

	^ palette
