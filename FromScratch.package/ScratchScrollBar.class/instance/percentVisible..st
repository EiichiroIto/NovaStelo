scroll bar protocol
percentVisible: percentVisible
	"Supply an optional floating fraction so slider can expand to indicate the percent of the content that is visible."

	sliderLength := ((percentVisible min: 1.0) * self maxSliderLength) rounded.
	sliderLength := sliderLength max: self minSliderLength.
	sliderLength = self maxSliderLength ifTrue: [self scrollFraction: 0].
	self changed.
