drawing
drawCursor: charIndex line: lineIndex on: aCanvas
	"Draw a cursor at the given character index on the given line."

	| line pair x p |
	line := lines at: lineIndex.
	line size = 0
		ifTrue: [ pair := #(0 0) ]
		ifFalse: [ pair := (renderer xRangesFor: line)
				at: (charIndex min: line size max: 1) ].
	x := charIndex > line size
		ifTrue: [ pair max ]
		ifFalse: [ pair min ].
	p := self offsetForLine: lineIndex.
	aCanvas
		fillRectangle: (p + (x @ 0) extent: 2 @ lineHeight)
		color: selectionColor