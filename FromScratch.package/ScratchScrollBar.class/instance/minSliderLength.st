event handling
minSliderLength
	"Answer the minimum slider length."

	bounds isWide
		ifTrue: [^ sliderEndForm width + sliderEndForm width]
		ifFalse: [^ sliderEndForm height + sliderEndForm height].
