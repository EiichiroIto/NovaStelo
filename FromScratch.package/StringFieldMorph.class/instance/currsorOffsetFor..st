private
currsorOffsetFor: characterOffset
	"Answer the insertion cursor x offset for the given character offset."

	| s xRanges xPairChar0 xPairCharLast startsOnLeft r xPairCharOffset |
	stringMorph contents size = 0 ifTrue: [^ 0].

	s := stringMorph stringToDisplay.
	xRanges := stringMorph xRangesFor: s.
	xPairChar0 := xRanges at: 1.
	xPairCharLast := xRanges last.
	startsOnLeft := xPairChar0 first < xPairCharLast last.

	"special case for a single character; double it to see if it is RTL"
	xRanges size = 1 ifTrue: [
		r := stringMorph xRangesFor: (s, s).
		startsOnLeft := r first first < r last last].

	"if string starts left-to-right, then put cursor on the left side left of first char, otherwise put it on the right side"
	characterOffset < 1 ifTrue: [
		startsOnLeft
			ifTrue: [^ xPairChar0 first]
			ifFalse: [^ xPairChar0 last - 1]].

	xPairCharOffset := xRanges at: (characterOffset min: xRanges size).

	"if string starts left-to-right, then put cursor on right size of character"
	startsOnLeft
		ifTrue: [^ xPairCharOffset last]
		ifFalse: [^ xPairCharOffset first].
