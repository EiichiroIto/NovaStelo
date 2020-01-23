drawing
drawSelectionFrom: startIndex to: endIndex line: lineIndex on: aCanvas
	"Draw the selection for the given character range of the given line on the given canvas."

	| line xRanges p pair w |
	line := lines at: lineIndex.
	xRanges := renderer xRangesFor: line.
	p := self offsetForLine: lineIndex.
	startIndex to: endIndex - 1 do: [:i |
		pair := xRanges at: (i min: line size max: 1).
		w := (pair last - pair first) abs.
		aCanvas fillRectangle: ((p + (pair first@0)) extent: w@lineHeight) color: selectionColor].
