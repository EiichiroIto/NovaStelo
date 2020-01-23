event handling
mouseMove: evt
	"Update the slider position if in drag mode."

	dragOffset ifNil: [^ self].  "not in slider drag mode"

	sliderStart := (self linearOffset: evt) + dragOffset.
	sliderStart := (sliderStart max: 0) min: (self maxSliderStart).
	self updateTarget.
	self changed.
