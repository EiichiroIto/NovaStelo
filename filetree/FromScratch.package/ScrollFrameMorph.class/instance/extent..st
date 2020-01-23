geometry
extent: aPoint
	"After setting my size, position and size my scrollbars and grow box. Also update my contents and scrollbar ranges."

	| inner w h |
	super extent: (aPoint truncated max: self minWidth@self minHeight).
	inner := self innerBounds.

	w := inner width.
	vScrollbar owner = self ifTrue: [w := w - vbarInset].
	hScrollbar position: inner left@(inner bottom - hbarInset).
	hScrollbar extent: w@hbarInset.

	h := inner height.
	hScrollbar owner = self ifTrue: [h := h - hbarInset].
	vScrollbar position: (inner right - vbarInset)@inner top.
	vScrollbar extent: vbarInset@h.

	cornerMorph position: (inner bottomRight - (vbarInset@hbarInset)).
	cornerMorph extent: vbarInset@hbarInset.

	self updateContentsExtent.
	self updateScrollbars.
