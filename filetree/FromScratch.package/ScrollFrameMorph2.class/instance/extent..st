geometry
extent: aPoint
	"After setting my size, position and size my scrollbars and grow box. Also update my contents and scrollbar ranges."

	| inner w h |
	super extent: (aPoint truncated max: self minWidth @ self minHeight).
	scrollBarStartInset
		ifNil: [ scrollBarStartInset := scrollBarEndInset := 0 ].	"needed during initialization"
	inner := self innerBounds.
	w := inner width - scrollBarStartInset.
	vScrollbar owner = self
		ifTrue: [ w := w - vbarInset ]
		ifFalse: [ w := w - scrollBarEndInset ].
	hScrollbar
		position: (inner left + scrollBarStartInset) @ (inner bottom - hbarInset).
	hScrollbar width: w.
	h := inner height - scrollBarStartInset.
	hScrollbar owner = self
		ifTrue: [ h := h - hbarInset ]
		ifFalse: [ h := h - scrollBarEndInset ].
	vScrollbar
		position: (inner right - vbarInset) @ (inner top + scrollBarStartInset).
	vScrollbar height: h.
	self updateContentsExtent.
	self updateScrollbars