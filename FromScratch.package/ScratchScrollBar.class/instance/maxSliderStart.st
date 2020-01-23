event handling
maxSliderStart
	"Answer the maximum sliderStart value given the slider's length."

	bounds isWide
		ifTrue: [^ bounds width - (sliderLength + sliderInsets left + sliderInsets right)]
		ifFalse: [^ bounds height - (sliderLength + sliderInsets top + sliderInsets bottom)].
