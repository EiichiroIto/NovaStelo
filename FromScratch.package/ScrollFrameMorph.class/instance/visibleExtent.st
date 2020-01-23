private
visibleExtent
	"Answer the extent of my visible area. That is, the area within my borders minus the space used for scrollbars."

	| clipToScrollBarEdge visibleW visibleH |
	clipToScrollBarEdge := false.
	clipToScrollBarEdge ifFalse: [^ self extent - (2 * borderWidth)].

	visibleW := self width - (2 * borderWidth).
	vScrollbar owner = self ifTrue: [visibleW := visibleW - vbarInset].
	visibleH := self height - (2 * borderWidth).
	hScrollbar owner = self ifTrue: [visibleH := visibleH - hbarInset].
	^ visibleW@visibleH
