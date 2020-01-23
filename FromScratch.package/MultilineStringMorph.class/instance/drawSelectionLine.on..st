drawing
drawSelectionLine: lineIndex on: aCanvas
	"Draw the selection for the entire line with the given index on the given canvas."

	| p w |
	p := self offsetForLine: lineIndex.
	w := renderer stringWidth: (lines at: lineIndex).
	aCanvas fillRectangle: (p extent: w@lineHeight) color: selectionColor.
