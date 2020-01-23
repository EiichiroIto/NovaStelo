accessing
scrollFraction
	"Answer the scroll fraction, a number between 0.0 and 1.0."

	| maxStart |
	(maxStart := self maxSliderStart) = 0 ifTrue: [^ 0.0].
	^ sliderStart asFloat / maxStart
