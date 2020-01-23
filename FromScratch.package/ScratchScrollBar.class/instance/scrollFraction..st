accessing
scrollFraction: aNumber
	"Set my scroll fraction, a number between 0.0 and 1.0."

	sliderStart := (((aNumber asFloat min: 1.0) max: 0.0) * self maxSliderStart) rounded.
	self changed.
