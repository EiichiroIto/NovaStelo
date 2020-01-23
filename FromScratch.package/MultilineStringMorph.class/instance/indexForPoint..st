private
indexForPoint: aPoint
	"Answer the character index for the given point in screen coordinates."
	"Note: This could be speeded up by doing a binary search for the character index, but it seems fast enough."

	| y lineNum x lineStart line xRanges pair |
	lines size = 0 ifTrue: [^ 1].

	y := aPoint y - (self top + self insetY).
	lineNum := ((y // lineHeight) + 1) max: 1.
	lineNum > lines size ifTrue: [^ (self startOfLine: lineNum) + 1].

	x := (aPoint x - self left - (self offsetForLine: lineNum) x) min: self width.
	x < 0 ifTrue: [  "start of a line"
		lineNum = 1 ifTrue: [^ 1] ifFalse: [^ self startOfLine: lineNum]].

	"search for character index"
	lineStart := self startOfLine: lineNum.
	line := lines at: lineNum.
	xRanges := renderer xRangesFor: line.
	1 to: line size do: [:i |
		pair := xRanges at: i.
		(x between: pair first and: pair second) ifTrue: [^ lineStart + i]].

	"end of line"
	lineNum = lines size
		ifTrue: [^ lineStart + line size + 1]
		ifFalse: [^ lineStart + line size].
