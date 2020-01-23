scrolling
hScrollPixels: hOffset
	"Scroll to the given horizontal offset in pixels. Zero is scrolled to the left and increasing values scroll right."

	| delta maxOffset |
	delta := (hOffset asInteger min: self maxScroll x) max: 0.
	contents left: ((self left + borderWidth) - delta) truncated.

	maxOffset := self maxScroll x.
	maxOffset > 0 ifTrue: [hScrollbar value: self hScrollPixels / maxOffset].
