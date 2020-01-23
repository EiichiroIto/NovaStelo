scrolling
vScrollPixels: vOffset
	"Scroll to the given vertical offset in pixels. Zero is scrolled to the top and increasing values scroll down."

	| delta maxOffset |
	delta := (vOffset asInteger min: self maxScroll y) max: 0.
	contents top: ((self top + borderWidth) - delta) truncated.

	maxOffset := self maxScroll y.
	maxOffset > 0 ifTrue: [vScrollbar value: self vScrollPixels / maxOffset].
