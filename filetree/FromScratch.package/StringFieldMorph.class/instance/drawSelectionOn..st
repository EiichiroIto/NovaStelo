drawing
drawSelectionOn: aCanvas

 	| xRanges clipC vInset offset selectionH rect pair start end |
	xRanges := stringMorph xRangesFor: stringMorph stringToDisplay.
	clipC := aCanvas copyClipRect: self innerBounds.
	vInset := borderWidth + 2.
	offset := stringMorph leftMargin@(self top + vInset).
	selectionH := self height - (2 * vInset).

	selectionStart = selectionEnd ifTrue: [
		blinkState ifNil: [blinkState := true].
		blinkState ifTrue: [
			rect := ((self currsorOffsetFor: selectionStart) - 1)@0 extent: 2@selectionH.
			clipC fillRectangle: (rect translateBy: offset) color: selectionColor].
		^ self].

	selectionStart < selectionEnd
		ifTrue: [
			start := selectionStart + 1.
			end := selectionEnd]
		ifFalse: [
			start := selectionEnd + 1.
			end := selectionStart].

	start to: end do: [:i |
		(i between: 1 and: xRanges size) ifTrue: [
			pair := xRanges at: i.
			rect := (pair first @ 0) corner: (pair second @ selectionH).
			clipC fillRectangle: (rect translateBy: offset) color: selectionColor]].
