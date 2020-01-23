intialization
initFrontFromForm: aForm
	"Initialize myself so that my frame is drawn in front of my submorphs, like a picture frame."

	| c f |
	frameInFront := true.

	c := (aForm colorAt: aForm extent // 2).
	f := aForm deepCopy.
	"f shapeFill: Color transparent interiorPoint: aForm extent // 2."
	self initFromForm: f.
	color := c.

