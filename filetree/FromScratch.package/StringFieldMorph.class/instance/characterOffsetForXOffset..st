private
characterOffsetForXOffset: screenX
	"Answer the character offset at the given width into the string."

	| x xRanges p best isLTR |
	stringMorph contents size = 0 ifTrue: [^ 0].

	x := screenX - stringMorph leftMargin.  "x offset within the string"
	xRanges := stringMorph xRangesFor: stringMorph stringToDisplay.

	1 to: xRanges size do: [:i |
		p := xRanges at: i.
		(x between: p first and: p last) ifTrue: [
			isLTR := self isLTRAt: i in: xRanges.
			(x - p first) <= (p last - x)   "left half of character?"
				ifTrue: [^ isLTR ifTrue: [i - 1] ifFalse: [i]]
				ifFalse: [^ isLTR ifTrue: [i] ifFalse: [i - 1]]]].

	"x is not within any x-range"
	x < 0
		ifTrue: [  "x is left of the entire string; find left-most char index"
			best := 1.
			1 to: xRanges size do: [:i |
				p := xRanges at: i.
				p first < (xRanges at: best) first ifTrue: [best := i]].
			best = 1 ifTrue: [best := 0].
			^ best]
		ifFalse: [  "x is right of entire string; find right-most char index"
			best := 1.
			1 to: xRanges size do: [:i |
				p := xRanges at: i.
				p last > (xRanges at: best) last ifTrue: [best := i]].
			best = 1 ifTrue: [best := 0].
			^ best].

