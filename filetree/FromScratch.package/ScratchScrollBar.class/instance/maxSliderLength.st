event handling
maxSliderLength
	"Answer the maximum slider length."

	bounds isWide
		ifTrue: [^ bounds width - (sliderInsets left + sliderInsets right)]
		ifFalse: [^ bounds height - (sliderInsets top + sliderInsets bottom)].

